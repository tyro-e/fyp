package org.grails.s3

import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.codehaus.groovy.grails.commons.ApplicationHolder

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

class S3Asset implements Serializable {

    static transients = ["tmpfile", 'fullBucketName', 'options']

    static mapping = {
        version false
        cache Boolean.valueOf(ConfigurationHolder.config.aws.disableHibernateCaching ?: false)
        key column: 'aws_key'
        status column: 'aws_status', index: 'idx_asset_status'
        optionList lazy: false
    }

    public static final String DEFAULT_LOCAL_ASSETS = 's3-plugin-temp'
    public static final String STATUS_BLANK = "blank"
    public static final String STATUS_TO_BE_REMOVED = "to-be-removed"
    public static final String STATUS_REMOVED = "removed"
    public static final String STATUS_NEW = "new"
    public static final String STATUS_INPROGRESS = "inprogress"
    public static final String STATUS_HOSTED = "hosted"
    public static final String STATUS_MISSING_FILE = "missing-local-file"
    public static final String STATUS_ERROR = 'error'

    public static final String SEPARATOR = "."

    static hasMany = [optionList: S3AssetOption]

    //persisted properites
    String localPath
    String localUrl
    String key

    /*
   The bucket to store this resource in. It will be prefixed with your S3 access key
   when uploaded to to S3 to ensure it is unique.
    */
    String bucket
    String title
    String description
    String mimeType
    String protocol = "http://"
    String status = STATUS_BLANK
    Long length
    Long lastModified
    Double percentTransferred
    Long bytesPerSecond
    Long bytesTransfered
    Map options
    String hostName // the host name of the server that created the asset

    //transient props
    File tmpfile

    static constraints = {
        localPath(nullable: true)
        key(unique: true)
        title(nullable: true)
        description(nullable: true)
        percentTransferred(nullable: true)
        hostName(nullable: true)
        bytesPerSecond(nullable: true)
        bytesTransfered(nullable: true)
        description(nullable: true)
        length(nullable: true)
        lastModified(nullable: true)
    }

    S3Asset() {}

    S3Asset(File file) {
        newFile(file);
    }

    S3Asset(File file, Map options) {
        newFile(file, options);
    }

    def newFile(File file) {
        newFile(file, [:]);
    }

    //method to setup s3 asset for upload with custom options for upload

    def newFile(File file, Map options) {
        this.tmpfile = file;
        this.length = file.length();
        this.lastModified = file.lastModified();
        this.localPath = this.tmpfile.canonicalPath;
        this.localUrl = "/" + (ConfigurationHolder.config.aws.localAssetPath ?: DEFAULT_LOCAL_ASSETS) + "/" + this.tmpfile.name
        this.optionList = parseOptions(options);
    }

    private List parseOptions(Map inMap) {
        def out = []
        inMap.each {k, v ->
            out << new S3AssetOption(name: k.toString(), value: v?.toString(), asset: this)
        }
        out
    }

    // Done for backwards compatibility

    public Map getOptions() {
        if (options == null) {
            options = [:]
            optionList.each {
                options[it.name] = it.value
            }
        }
        options
    }

    //read only S3 url
    transient url = {
        return url()
    }

    String url() {
        return protocol + getFullBucketName() + SEPARATOR +
                (ConfigurationHolder.config.aws.domain ?: S3Utils.DEFAULT_HOST) + "/" + this.key
    }

    /**
     Returns the full bucket name which is <access key>.<bucket>
     */
    String getFullBucketName() {
        def s = ApplicationHolder.application.mainContext.getBean('s3BucketService')
        return s.getActualS3BucketName(this)
    }

    String toString() {
        return "Asset ${id}"
    }

    def beforeInsert = {
        try {
            hostName = InetAddress.getLocalHost().getHostName()
        } catch (java.net.UnknownHostException uhe) {
        }
    }

}
