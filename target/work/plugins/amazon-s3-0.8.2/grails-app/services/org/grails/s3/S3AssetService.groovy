package org.grails.s3

import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.hibernate.StaleObjectStateException
import org.jets3t.service.S3Service
import org.jets3t.service.S3ServiceException
import org.jets3t.service.acl.AccessControlList
import org.jets3t.service.impl.rest.httpclient.RestS3Service
import org.jets3t.service.model.S3Bucket
import org.jets3t.service.model.S3Object
import org.jets3t.service.multithread.S3ServiceMulti
import org.jets3t.service.security.AWSCredentials
import org.springframework.beans.factory.InitializingBean
import org.springframework.dao.TransientDataAccessException
import org.grails.s3.*
import org.apache.commons.collections.map.LRUMap
import org.jets3t.service.security.EncryptionUtil

/* Copyright 2006-2007 the original author or authors.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*      http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*
* For more information please visit www.cantinaconsulting.com
* or email info@cantinaconsulting.com
*/

class S3AssetService implements InitializingBean {

    S3BucketService s3BucketService
    S3KeyService s3KeyService
    S3ClientService s3ClientService

    def sessionFactory

    S3Utils utils

    boolean transactional = false

    //TODO: makes this a MAP of buckets
    private static S3Bucket defaultBucket

    private static EncryptionUtil e
    private static multipleKeys = false
    private static config
    private static hostName
    private static final String PUT = 'putObjects'
    private static final String DELETE = 'deleteObjects'
    private static final String SECRETKEY_CHARSET = 'utf-16'

    //TODO replace this with jMimeMagic?
    def mimeTypeMap = [
            "image/png": "png",
            "image/jpeg": "jpg",
            "image/gif": "gif",
            "image/tiff": "tiff",
            "application/pdf": "pdf",
            "video/mpeg": "mpeg",
            "video/mp4": "mp4",
            "video/quicktime": "mov",
            "video/x-ms-wmv": "wmv",
            "text/html": "html",
            "text/xml": "xml",
            "audio/mpeg": "mp3",
            "application/octet-stream": "flv"
    ]

    void afterPropertiesSet() {
        config = ConfigurationHolder.config
        def passwd = config.aws.secretKeyEncryptPassword ?: 'aws.secretKeyEncryptPassword'
        e = new EncryptionUtil(passwd)
        buildLocalAssetPath()
        try {
            hostName = InetAddress.getLocalHost().getHostName()
        } catch (java.net.UnknownHostException uhe) {
        }
    }

    private buildLocalAssetPath() {
        def res = new File(getLocalAssetPathFromConfig())
        if (!res.exists()) {
            res.mkdir()
        }
    }

    private getLocalAssetPath() {
        new File(getLocalAssetPathFromConfig())
    }

    private def getLocalAssetPathFromConfig() {
        return config.aws.localAssetPath ?: S3Asset.DEFAULT_LOCAL_ASSETS
    }

    File getNewTmpLocalFile(String mimeType) {
        Map map = mimeTypeMap
        def ext = null

        if (map.containsKey(mimeType)) {
            ext = "." + map[mimeType]
        }

        File.createTempFile("s3Asset", ext, getLocalAssetPath())
    }

    def put(S3Asset a) {
        //retreive options
        boolean async = Boolean.valueOf(a.options.get("addAsync") ?: 'true');

        //check to see if a key has been assigned to the asset
        if (!a.key) {
            def key = s3KeyService.getKey(a);
            def count = S3Asset.countByKeyAndBucket(key.toString(), a.bucket);
            if (count > 0) {
                throw new IllegalArgumentException("This key and bucket combination is already used by s3");
            }
            a.key = key
        }
        if (!a.bucket) {
            a.bucket = config.aws.bucketName ?: S3BucketService.DEFAULT_BUCKET
        }
        if (a.options.secretKey && !a.id) {
            def secret = a.options.secretKey
            byte[] bytes = e.encrypt(secret)
            a.options.secretKey = e.encrypt(secret).collect {byte b -> b.toInteger()}.join(':')
        }
        if (a.validate()) {
            //set the status as new
            a.status = S3Asset.STATUS_NEW
            try {
                a.save(flush: true)
            } catch (StaleObjectStateException s) {
                recoverSetStatus(a, S3Asset.STATUS_NEW)
            } catch (TransientDataAccessException e) {
                recoverSetStatus(a, S3Asset.STATUS_NEW)
            }
            if (!async) {
                putAsset(a)
            }
        } else {
            if (config.aws.throwOnInvalidAsset ?: false) {
                throw new RuntimeException("Invalid S3Asset passed to S3AssetService.put: " + a.errors)
            } else {
                log.error("Got errors populating the S3Asset:")
                a.errors.allErrors.each {
                    log.error(it)
                }
                a.status = S3Asset.STATUS_ERROR
                a.save(flush: true)
            }
        }
    }

    // Backwards compatibility
    public S3Service getS3(String accessKey, String secretKey) {
        s3ClientService.getS3(accessKey, secretKey)
    }

    private putAsset(S3Asset a) {
        processAssets([a], PUT)
    }

    private processAssets(List assets, String method) {
        Map assetsPerKey = buildAssetMap(assets)
        assetsPerKey.each {accessKey, toDo ->
            log.debug "Procesing(${method}) ${toDo.assets.size()} assets for key ${accessKey}"
            multiOperation(toDo.assets, toDo.client, method)
        }
    }

    private Map buildAssetMap(List assets) {
        def uploads = [:]
        assets.each {a ->
            String access = a.options.get("accessKey") ?: config.aws.accessKey ?: S3Utils.DEFAUL_KEY
            def toDo = uploads[access]
            if (!toDo) {
                String secret
                if (a.options.get("accessKey")) {
                    secret = a.options.get("secretKey")
                    if (secret) {
                        def bytes = secret.split(':').collect {Integer.parseInt(it).byteValue()} as byte[]
                        secret = new String(e.decrypt(bytes))
                    } else {
                        log.error("Asset ${a.id} has an accessKey specified (${access}) but no matching secretKey")
                        a.status = S3Asset.STATUS_ERROR
                        a.save(flush: true)
                        return
                    }
                } else {
                    secret = config.aws.secretKey ?: S3Utils.DEFAUL_KEY
                }

                def s3 = s3ClientService.getS3(access, secret)
                toDo = [client: s3, assets: []]
                uploads[access] = toDo
            }
            toDo.assets << a
        }

        return uploads
    }

    private buildObjectList(List assets, S3Service s3) {
        def objs = []
        assets.each {a ->
            S3Object obj = new S3Object()
            if (a.localPath) {
                File f = new File(a.localPath)
                obj.setDataInputFile(f)
                obj.setContentLength(f.size())
            }
            //TODO support completely custom acls, need to persist xml or some kind of model
            def acl = a.options.acl
            if (acl) {
                try {
                    acl = AccessControlList."${acl}"
                } catch (MissingPropertyException e) {
                    log.error "Invalid acl specified for asset ${a.id}: ${acl}. It should match one of the constants from org.jets3t.service.acl.AccessControlList"
                    a.status = S3Asset.STATUS_ERROR
                    a.save(flush: true)
                    return
                }
            }
            obj.setAcl(acl ?: AccessControlList.REST_CANNED_PUBLIC_READ)
            obj.setBucketName(a.fullBucketName ?: s3BucketService.getBucketName())
            obj.setContentType(a.mimeType)
            obj.setKey(a.key)

            //TODO: add metadata to S3 object
            objs << obj
        }
        return objs
    }

    def delete(S3Asset a) {
        //retreive options
        boolean async = Boolean.valueOf(a.options.get("deleteAsync") ?: 'true');

        if (a.validate()) {
            //set the status as removed
            a.status = S3Asset.STATUS_TO_BE_REMOVED
            try {
                a.save(flush: true)
            } catch (StaleObjectStateException s) {
                recoverSetStatus(a, S3Asset.STATUS_TO_BE_REMOVED)
            } catch (TransientDataAccessException e) {
                recoverSetStatus(a, S3Asset.STATUS_TO_BE_REMOVED)
            }

            if (!async) {
                deleteAsset(a)
            }
        } else {
            if (config.aws.throwOnInvalidAsset ?: false) {
                throw new RuntimeException("Invalid S3Asset passed to S3AssetService.put: " + a.errors)
            } else {
                log.error("Got errors deleting the S3Asset:")
                a.errors.allErrors.each {
                    log.error(it)
                }
                a.status = S3Asset.STATUS_ERROR
                a.save(flush: true)
            }

        }
    }

    private def recoverSetStatus(S3Asset a, status) {
        S3Asset.withSession {org.hibernate.Session session ->
            session.evict(a)
            Thread.currentThread().sleep(200)
            a.refresh()
            a.status = status
            try {
                a.save(flush: true)
            } catch (TransientDataAccessException e) {
                session.evict(a)
                Thread.currentThread().sleep(200)
                a.refresh()
                a.status = status
                a.save(flush: true)
            }
        }
    }

    private deleteAsset(S3Asset a) {
        processAssets([a], DELETE)
    }

    def syncNew() {
        def batch = config.aws.batchSize ?: 10
        def results = S3Asset.createCriteria().list([max: batch * 10]) {
            eq('status', S3Asset.STATUS_NEW)
            or {
                isNull('hostName')
                eq('hostName', hostName)
            }
        }
        def assets = []
        results.each {asset ->
            if (assets.size() == batch) {
                try {
                    processAssets(assets, PUT)
                } catch (Throwable t) {
                    log.error("Uable to sync new assets ${assets}", t)
                }
                assets = []
            }
            try {
                if (!new File(asset.localPath).exists()) {
                    if (!(config.aws.ignoreMissingLocal ?: false)) {
                        try {
                            asset.status = S3Asset.STATUS_MISSING_FILE
                            asset.save(flush: true)
                        } catch (StaleObjectStateException s) {
                            recoverSetStatus(a, S3Asset.STATUS_MISSING_FILE)
                        } catch (TransientDataAccessException e) {
                            recoverSetStatus(a, S3Asset.STATUS_MISSING_FILE)
                        }
                    } else {
                        log.debug("Ignored missing file for asset ${asset.id}")
                    }
                } else {
                    assets << asset
                }
            } catch (Throwable t) {
                log.error("Unable to upload asset ${asset.id}", t)
            }
        }
        if (assets.size() > 0) {
            try {
                processAssets(assets, PUT)
            } catch (Throwable t) {
                log.error("Uable to sync new assets ${assets}", t)
            }
        }
    }

    def syncRemoved() {
        def batch = config.aws.batchSize ?: 10
        def results = S3Asset.createCriteria().list([max: batch * 10]) {
            eq('status', S3Asset.STATUS_TO_BE_REMOVED)
            or {
                isNull('hostName')
                eq('hostName', hostName)
            }
        }
        def assets = []
        results.each {asset ->
            if (assets.size() == batch) {
                try {
                    processAssets(assets, DELETE)
                } catch (Throwable t) {
                    log.error("Uable to sync deleted assets ${assets}", t)
                }
                assets = []
            }
            assets << asset
        }
        if (assets.size() > 0) {
            try {
                processAssets(assets, DELETE)
            } catch (Throwable t) {
                log.error("Uable to sync deleted assets ${assets}", t)
            }
        }
    }

    private def multiOperation(List assets, S3Service s3, String method) {
        S3ServiceMulti s3M = new S3ServiceMulti(s3, new HandleS3Events(assets, sessionFactory));
        def objs = buildObjectList(assets, s3)
        def bucketMap = [:]
        objs.each {S3Object o ->
            def list = bucketMap[o.getBucketName()]
            if (!list) {
                list = []
                bucketMap[o.getBucketName()] = list
            }
            list << o
        }
        bucketMap.each {String bucketName, List objects ->
            def bucket = s3.getOrCreateBucket(bucketName)
            if (!s3M."${method}"(bucket, objects as S3Object[])) {
                log.error('S3 uploads failed, check log for individual errors')
            }
        }
    }

}