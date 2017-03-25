package org.grails.s3

import org.grails.s3.S3Asset

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



class S3KeyService {

    //other key strategies can be developed here
    static final RAND = new Random()

    def getKey(S3Asset a) {

        //create unique key for the file on S3
        def key = new UUID(System.currentTimeMillis(),
                (System.currentTimeMillis() * System.currentTimeMillis() + RAND.nextInt(10000)) as long);

        //other key strategies can be developed using the information
        //about the asset

        return key;

    }

}