package org.grails.s3

import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.grails.s3.S3AssetService
import org.grails.s3.S3Utils

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
class S3SyncNewJob {

    static triggers = {
        simple(name: 'S3SyncNewJob',
                repeatInterval: ConfigurationHolder.config.aws.timeout ?: 3000l,
                startDelay: ConfigurationHolder.config.aws.startDelay ?: 30000l)
    }

    static concurrent = false
    static durability = true
    static volatility = false

    S3AssetService s3AssetService

    def execute() {
        log.debug("Starting new file sync with Amazon S3")

        def start = System.currentTimeMillis()

        s3AssetService.syncNew()

        def end = System.currentTimeMillis()

        log.debug("Finished new file sync with Amazon S3 (time: " + (end - start) / 1000 + "s)")
    }
}
