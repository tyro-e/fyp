package fyp

class Content 
{
    String name
    String type
    String absoluteUrl

    static belongsTo = [event: Event]

    static constraints = {
        name nullable: true
        type nullable: true
        absoluteUrl nullable: true
    }
}
