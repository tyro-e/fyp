package fyp

import org.grails.comments.*
import org.grails.rateable.*

class Event implements Rateable, Commentable  {


	int bandsintown_id
	String artist
	String venue
	String ticket_url
	String ticketStatus
    String eventTime

    String livestream

	//int longitude
	//int latitude

	

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
