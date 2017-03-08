package fyp

import grails.rest.*
import grails.converters.*
import groovyx.net.http.HTTPBuilder
import static groovyx.net.http.Method.GET
import static groovyx.net.http.ContentType.JSON


class EventController extends RestfulController
{
    static responseFormats = ['json', 'xml']

    EventController() {
        super(Event)
    }

    def populate() {

        def http = new HTTPBuilder( 'http://api.bandsintown.com/events/search.json?&api_version=2.0&app_id=FYP&location=Dublin,Ireland' )

        def JSONData

        http.request( GET, JSON ) {

            response.success = { resp, json ->
            
                JSONData = JSON.parse(json.text)
            }
        }

        int numberEvents = 0

        JSONData.each {

            def event = new Event(artist: it.artists.name.toString(), venue: it.venue.name.toString())

            if (!event.save()) {
                event.errors.allErrors.each {
                    println it
                }
            } else {
                numberEvents++
            }
        }

        render "${numberEvents} events loaded"
    }
}
