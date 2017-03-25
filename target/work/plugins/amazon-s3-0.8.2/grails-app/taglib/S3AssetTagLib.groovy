import org.grails.s3.S3Asset

class S3AssetTagLib {

    static namespace = 's3'

    def createLinkTo = { attrs ->

        S3Asset a = attrs["asset"]

        switch (a.status) {
        case S3Asset.STATUS_NEW:
        case S3Asset.STATUS_INPROGRESS:
            //FIX this functionality is all broken at the moment...
            out << grailsAttributes.getApplicationUri(request) + a.localUrl
            break
        case S3Asset.STATUS_HOSTED:
            out << a.url()
            break
        case S3Asset.STATUS_REMOVED:
        case S3Asset.STATUS_BLANK:
            // TODO: must get a "not found" image for this
            break
        }
    }
}