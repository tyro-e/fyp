package fyp

class Event {

	//int id
	int bandsintown_id
	String artist

	String venue
	boolean ticketStatus
	Date eventTime
	String ticket_url

	Double longitude
	Double latitude

	
	
	/*
	static hasMany = [artists:Artist]
	static belongsTo = Artist
	*/

    static constraints = {
    	bandsintown_id unique:true
    }
}
