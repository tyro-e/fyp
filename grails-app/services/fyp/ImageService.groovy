package fyp

import com.amazonaws.services.s3.model.AmazonS3Exception
import com.amazonaws.services.s3.model.CannedAccessControlList
import org.apache.commons.io.FilenameUtils

class ImageService {

    static transactional = false
    def amazonS3Service
    def grailsApplication

    def uploadImageToAmazon(String title, byte[] bytes, String type) {
        title = removeWrongChars(title)
        def tempDir = new File(getTempDirPath())
        def file = new File(tempDir.getAbsolutePath() + "/" + title)
        if (bytes) {
            file = File.createTempFile(title, new Date().time.toString())
            file << bytes
        }

        String dirPrefix = new Date().format("yyyy-MM-dd/")

        if (file.exists()) {
            def bucket = grailsApplication.config.grails.plugin.awssdk.s3.bucket
            //First check that here are no file with same name
            try {
                if (amazonS3Service.exists(bucket, dirPrefix + title)) {
                    title = appendToFileName(title, FilenameUtils.getExtension(title), new Date().time?.toString())
                }
            } catch (AmazonS3Exception e) {
                log.error('Error in upload image to Amazon ' + e)
            }

            def upload = amazonS3Service.transferFile(bucket, dirPrefix + title, file, CannedAccessControlList.PublicRead)
            while (!upload.done) {
                log.info("Loading file to Amazone")
            }
            return "https://${bucket}.s3.amazonaws.com/${dirPrefix + title}"
        }
    }

    String getTempDirPath() {
        def path = getAbsolutePath() + "temp"
        def dir = new File(path)
        if (!dir.exists()) {
            dir.mkdirs()
        }
        return path
    }

    String getAbsolutePath() {
        return grailsApplication.config.workareaPath + "/"
    }

    private String removeWrongChars(String text) {
        return text?.replaceAll("[^a-zA-Z0-9\\s\\._-]", "")?.replaceAll(' ', '');
    }

    String appendToFileName(String fileName, String extension, String valueToAppend) {
        if (fileName) {
            return fileName - ".$extension" + "_${valueToAppend}." + extension
        } else {
            return null
        }
    }
}