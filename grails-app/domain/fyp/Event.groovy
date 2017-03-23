package fyp

import org.grails.comments.*
import org.grails.rateable.*

class Event implements Rateable, Commentable  {


	int bandsintown_id
	String artist
	String venue
	String ticket_url
	String ticketStatus

	//Date eventTime
	//int longitude
	//int latitude

	

    static constraints = {
    	bandsintown_id unique:true

    	
    }
}
