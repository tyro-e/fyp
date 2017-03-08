package fyp

class Event {

	//int id
	//int bandsintown_id
	String artist
	String venue
	/*
	Date eventTime
	String ticket_url
	int longitude
	int latitude
	Boolean livestream
	*/

	static hasMany = [artists:Artist]
	static belongsTo = Artist

    static constraints = {
    	//bandsintown_id unique:true
    }
}
