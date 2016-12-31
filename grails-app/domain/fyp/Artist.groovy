package fyp

class Artist {

	Long id
	String artistName
	String artistGenre
	String artistDescription
	String artistNationality

	static hasMany = [events:Event]

    static constraints = {
    	artistName blank:false
    	artistGenre blank:false
    	artistDescription nullable: true
    	artistNationality nullable: true
    }
}
