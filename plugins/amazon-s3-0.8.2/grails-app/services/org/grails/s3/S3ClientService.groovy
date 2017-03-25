package org.grails.s3

import org.jets3t.service.S3Service
import org.jets3t.service.security.AWSCredentials
import org.jets3t.service.impl.rest.httpclient.RestS3Service
import org.apache.commons.collections.map.LRUMap
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.springframework.beans.factory.InitializingBean


public class S3ClientService implements InitializingBean {

    private static Map s3Cache

    void afterPropertiesSet() {
        s3Cache = Collections.synchronizedMap(new LRUMap(ConfigurationHolder.config.aws.s3clientCacheSize ?: 10))
    }

    public S3Service getS3(String accessKey, String secretKey) {
        def s3 = s3Cache.get(accessKey)
        if (!s3) {
            log.debug('Creating new client for access key ' + accessKey)
            AWSCredentials awsCredentials = new AWSCredentials(accessKey, secretKey);
            s3 = new RestS3Service(awsCredentials)
            s3Cache.put(accessKey, s3)
        }
        return s3
    }

}