package org.grails.s3

import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.grails.s3.S3Asset
import org.grails.s3.S3Utils
import org.jets3t.service.S3Service
import org.jets3t.service.model.S3Object

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


public class S3BucketService {

    static final DEFAULT_BUCKET = 'grails-s3-plugin'

    S3ClientService s3ClientService

    String getBucketName() {
        def config = ConfigurationHolder.config
        return getActualS3BucketName(config.aws.bucketName ?: DEFAULT_BUCKET)
    }

    //get bucket name using the information about the asset

    String getBucketName(S3Asset a) {
        return a.bucket
    }

    /**
     * This will remove a bucket and all it's contents
     */
    void deleteBucket(String bucketName, String accessKey, String secretKey) {
        def config = ConfigurationHolder.config
        def key = accessKey ?: config.aws.accessKey
        def secret = secretKey ?: config.aws.secretKey

        def actualBucket = getActualS3BucketName(bucketName, key)
        S3Service s3 = s3ClientService.getS3(key, secret)
        def objs = s3.listObjects(actualBucket, null, null, 1000)
        log.debug("Deleting bucket ${bucketName}, including ${objs.size()} objects...")
        objs.each {S3Object it ->
            def id = it.getKey()
            s3.deleteObject(actualBucket, id)
            log.debug('Deleted ' + id)
        }
        S3Asset.executeUpdate('Delete from S3Asset where bucket = ?', [bucketName])
        s3.deleteBucket(actualBucket)
        log.debug("Bucket ${bucketName} deleted")
    }

    String getActualS3BucketName(String bucketName, String accessKey) {
        def shouldPrefix = ConfigurationHolder.config.aws.prefixBucketWithKey
        if (shouldPrefix == null || shouldPrefix instanceof ConfigObject) {
            shouldPrefix = true
        }
        if (shouldPrefix) {
            return (accessKey ?: (ConfigurationHolder.config.aws.accessKey ?: S3Utils.DEFAUL_KEY)).toLowerCase() +
                    S3Asset.SEPARATOR + bucketName.toLowerCase()
        } else {
            bucketName.toLowerCase()
        }
    }

    String getActualS3BucketName(S3Asset a) {
        return getActualS3BucketName(a.bucket, a.options['accessKey'])
    }
}
