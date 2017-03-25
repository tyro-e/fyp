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
*
* For more information please visit www.cantinaconsulting.com
* or email info@cantinaconsulting.com
*/

class AmazonS3GrailsPlugin {
    def version = '0.8.2'
	def grailsVersion = "1.1 > *"	
    def dependsOn = [quartz: "0.4.1 > *"]
	
    def author = "Cantina Consulting, Refactor"
    def authorEmail = "info@cantinaconsulting.com, contact@refactor.com.au"
    def title = "Provides tools to host media assets on Amazon's Simple Storage Service (S3)"
    def documentation = "http://www.grails.org/plugin/amazon-s3"
    def description = '''\
This plugin is written for the Groovy on Grails web application framework, and intends to make it relatively easy to host media files such as images, Flash, movies and audio all on the Amazon Web Services Simple Storage Service (S3).  The goals of this plugin are as follows:

* Host and manage media assets on Amazon S3 for storage and performance advantages
* Provide easy mechanisms to reference S3-hosted assets in Grails applications
* Make most efficient and cost-effective use of S3 hosting resources

To achieve these goals, the plugin provides services to manage static media assets for a Grails application.  For the first revision of the plugin, the focus is on managing user uploaded static content.  Later revisions will place a focus on providing tools to migrate existing static content in a site (such as items under the /images folder) into S3.

This plugin uses the excellent JetS3t Toolkit (http://jets3t.s3.amazonaws.com/) to communicate with the Amazon S3 service.
'''


    def doWithSpring = {
    }
    def doWithApplicationContext = {applicationContext ->
    }
    def doWithWebDescriptor = {xml ->
    }
    def doWithDynamicMethods = {ctx ->
    }
    def onChange = {event ->
        // the event contains: event.application and event.applicationContext objects
    }
    def onApplicationChange = {event ->
        // the event contain: event.source, event.application and event.applicationContext objects
    }
}
