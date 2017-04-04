package fyp

import grails.rest.*
import grails.converters.*
import groovyx.net.http.HTTPBuilder
import static groovyx.net.http.Method.GET
import static groovyx.net.http.ContentType.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional


class EventController extends RestfulController
{
    //static responseFormats = ['json', 'xml']

    EventController() {
        super(Event)
    }

    def populate() {

        def http = new HTTPBuilder( 'http://api.bandsintown.com/events/search.json?&api_version=2.0&app_id=FYP&location=Dublin,Ireland' )

        def JSONData

        http.request( GET, JSON ) 
        {
            response.success = { resp, json -> JSONData = JSON.parse(json.text) }
        }

        int numberEvents = 0

        JSONData.each {

            String artistName1 = it.artists.name.toString();
            String artistName2 = artistName1.replace("[","").replace("]","");

            def event = new Event(  
                                    bandsintown_id: it.id.toString(),
                                    artist: artistName2, 
                                    venue: it.venue.name.toString(),
                                    ticket_url: it.ticket_url.toString(),
                                    ticketStatus: it.ticket_status.toString(),
                                    eventTime: it.datetime.toString())

                                    
            if (!event.save()) {
                event.errors.allErrors.each {
                    println it
                }
            } 

            else {
                numberEvents++
            }
        }

        render "${numberEvents} events loaded"
    }

    static scaffold = true
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    /*
    def index(Integer max) 
    {
        params.max = Math.min(max ?: 10, 100)
        respond Event.list(params), model:[eventInstanceCount: Event.count()]
    }
    */


    def index() 
    {
        int eventCount = Event.count()
        int startingPoint = eventCount - 50

        def events = Event.createCriteria().list
        {
            order('id')
            firstResult(startingPoint)
            maxResults(50)
        }

        respond events
    }


    def show(Event eventInstance) {
        respond eventInstance
    }

    def create() {
        respond new Event(params)
    }

    @Transactional
    def save(Event eventInstance) {
        if (eventInstance == null) {
            notFound()
            return
        }

        if (eventInstance.hasErrors()) {
            respond eventInstance.errors, view:'create'
            return
        }

        eventInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'eventInstance.label', default: 'Event'), eventInstance.id])
                redirect eventInstance
            }
            '*' { respond eventInstance, [status: CREATED] }
        }
    }

    def edit(Event eventInstance) {
        respond eventInstance
    }

    @Transactional
    def update(Event eventInstance) {
        if (eventInstance == null) {
            notFound()
            return
        }

        if (eventInstance.hasErrors()) {
            respond eventInstance.errors, view:'edit'
            return
        }

        eventInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Event.label', default: 'Event'), eventInstance.id])
                redirect eventInstance
            }
            '*'{ respond eventInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Event eventInstance) {

        if (eventInstance == null) {
            notFound()
            return
        }

        eventInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Event.label', default: 'Event'), eventInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'eventInstance.label', default: 'Event'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }


}