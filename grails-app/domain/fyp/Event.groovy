package fyp

class Event {

	Long id
	Boolean livestream
	Date eventTime
	Double price

	static hasMany = [artists:Artist]
	static belongsTo = Artist

    static constraints = {
    	livestream blank:false
    	eventTime blank:false
    	price blank:false
    }
}
