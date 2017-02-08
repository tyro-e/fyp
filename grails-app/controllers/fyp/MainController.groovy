package fyp
import org.springframework.web.context.request.RequestContextHolder


class MainController {

    def homepage() 
    { 

    }
}


class MenuTagLib {
    static namespace = 'html'

  	def render = {attrs ->

    	def filePath = attrs.file

	    if (!file) {
	      throwTagError("'file' attribute must be provided")
	    }

	    def htmlContent = new File(filePath).text
	    out <<  g.render(template: "/bandsintown")
	}
}
