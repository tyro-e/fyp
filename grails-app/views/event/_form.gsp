<%@ page import="fyp.Event" %>



<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'artist', 'error')} ">
	<label for="artist">
		<g:message code="event.artist.label" default="Artist" />
		
	</label>
	<g:textField name="artist" value="${eventInstance?.artist}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'artists', 'error')} ">
	<label for="artists">
		<g:message code="event.artists.label" default="Artists" />
		
	</label>
	
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'venue', 'error')} ">
	<label for="venue">
		<g:message code="event.venue.label" default="Venue" />
		
	</label>
	<g:textField name="venue" value="${eventInstance?.venue}"/>
</div>

