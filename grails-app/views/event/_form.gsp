<%@ page import="fyp.Event" %>



<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'bandsintown_id', 'error')} required">
	<label for="bandsintown_id">
		<g:message code="event.bandsintown_id.label" default="Bandsintownid" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="bandsintown_id" type="number" value="${eventInstance.bandsintown_id}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'artist', 'error')} ">
	<label for="artist">
		<g:message code="event.artist.label" default="Artist" />
		
	</label>
	<g:textField name="artist" value="${eventInstance?.artist}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'ticketStatus', 'error')} ">
	<label for="ticketStatus">
		<g:message code="event.ticketStatus.label" default="Ticket Status" />
		
	</label>
	<g:textField name="ticketStatus" value="${eventInstance?.ticketStatus}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'ticket_url', 'error')} ">
	<label for="ticket_url">
		<g:message code="event.ticket_url.label" default="Ticketurl" />
		
	</label>
	<g:textField name="ticket_url" value="${eventInstance?.ticket_url}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'venue', 'error')} ">
	<label for="venue">
		<g:message code="event.venue.label" default="Venue" />
		
	</label>
	<g:textField name="venue" value="${eventInstance?.venue}"/>
</div>

