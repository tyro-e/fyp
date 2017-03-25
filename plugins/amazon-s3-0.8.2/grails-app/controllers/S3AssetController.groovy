import org.grails.s3.S3Asset
import org.grails.s3.S3AssetService

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

class S3AssetController {

    S3AssetService s3AssetService
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        if(!params.max) params.max = 10
        [ s3AssetList: S3Asset.list( params ) ]
    }

    def show = {
        [ s3Asset : S3Asset.get( params.id ) ]
    }

    def delete = {

        def s3Asset = S3Asset.get( params.id )

        if(s3Asset) {

            //delete the s3Asset with the S3AssetService
            s3AssetService.delete(s3Asset);
            
            flash.message = "S3Asset ${params.id} deleted"
            redirect(action:list)
        }
        else {
            flash.message = "S3Asset not found with id ${params.id}"
            redirect(action:list)
        }
    }
    

    def edit = {
        def s3Asset = S3Asset.get( params.id )

        if(!s3Asset) {
            flash.message = "S3Asset not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ s3Asset : s3Asset ]
        }
    }

    def update = {

        def s3Asset = S3Asset.get( params.id )

        if(s3Asset) {

            s3Asset.properties = params

            if(!s3Asset.hasErrors()) {

                def f = request.getFile('myFile')

                if(!f.empty) {

                    //create temporary file to hold submitted file
                    def tmp = s3AssetService.getNewTmpLocalFile(f.contentType)

                    //transfer submitted content to file
                    f.transferTo( tmp )

                    s3Asset.newFile(tmp);
                    s3Asset.mimeType = f.contentType;
                    s3AssetService.put(s3Asset);

                    flash.message = 's3asset.file.uploaded'
                    redirect(action:'index')

                } else {

                    flash.message = 's3asset.file.empty'
                    render(view:'edit',model:[s3Asset:s3Asset])
                }

                flash.message = "S3Asset ${params.id} updated"

                render(view:'list',model:[s3Asset:s3Asset])

           } else {
                render(view:'edit',model:[s3Asset:s3Asset])
           }
        }
        else {
            flash.message = "S3Asset not found with id ${params.id}"
            redirect(action:edit,id:params.id)
        }
    }

    def create = {
        def s3Asset = new S3Asset()
        s3Asset.properties = params
        return ['s3Asset':s3Asset]
    }

    def save = {

        def s3Asset = new S3Asset(params)

        if(!s3Asset.hasErrors()) {

            def f = request.getFile('myFile')

            if(!f.empty) {

                //create temporary file to hold submitted file
                def tmp = s3AssetService.getNewTmpLocalFile(f.contentType)

                //transfer submitted content to file
                f.transferTo( tmp )

                s3Asset.newFile(tmp);
                s3Asset.mimeType = f.contentType;
                s3AssetService.put(s3Asset);

                flash.message = 's3asset.file.uploaded'
                redirect(action:'index')

            } else {
                flash.message = 's3asset.file.empty'
                render(view:'create',model:[s3Asset:s3Asset])
            }

            render(view:'list',model:[s3Asset:s3Asset])
        }
        else {
            render(view:'create',model:[s3Asset:s3Asset])
        }
    }
}
