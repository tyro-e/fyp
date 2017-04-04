package fyp

import org.grails.comments.*
import org.grails.rateable.*
import com.amazonaws.services.s3.model.*

class Event implements Rateable, Commentable  {


	int bandsintown_id
	String artist
	String venue
	String ticket_url
	String ticketStatus
    String eventTime
    String livestream



	

    static constraints = 
    {
    	bandsintown_id unique:true
        livestream nullable:true

    }


    def onAddComment = { comment ->
        // post processing logic for newly added comment
    }

    Double getAvgRating() {
        // Dynamic call to method added by Rateable plugin.
        return averageRating
    }

    Integer getRatingCount() {
        return totalRatings
    }
}
