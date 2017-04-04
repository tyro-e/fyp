<%@ page import="fyp.Event" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		
		<link rel="stylesheet" href="${resource(dir:'css',file:'livestream.css')}" />

		<rateable:resources/>
		<style type="text/css">
			#search-form, .form-control {
    margin-bottom: 20px;
}
.cover {
    width: 300px;
    height: 300px;
    display: inline-block;
    background-size: cover;
}
.cover:hover {
    cursor: pointer;
}
.cover.playing {
    border: 5px solid #e45343;
}
		</style>
		
	</head>
	<body>
		<a href="#show-event" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

		<div id="show-event" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list event">
			
				<g:if test="${eventInstance?.bandsintown_id}">
				<li class="fieldcontain">
					<span id="bandsintown_id-label" class="property-label"><g:message code="event.bandsintown_id.label" default="Bandsintownid" /></span>
					
						<span class="property-value" aria-labelledby="bandsintown_id-label"><g:fieldValue bean="${eventInstance}" field="bandsintown_id"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.artist}">
				<li class="fieldcontain">
					<span id="artist-label" class="property-label"><g:message code="event.artist.label" default="Artist" /></span>
					
					<span class="property-value" id = "artistName" aria-labelledby="artist-label">
						<g:fieldValue bean="${eventInstance}" field="artist"/>
					</span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.ticketStatus}">
				<li class="fieldcontain">
					<span id="ticketStatus-label" class="property-label"><g:message code="event.ticketStatus.label" default="Ticket Status" /></span>
					
						<span class="property-value" aria-labelledby="ticketStatus-label"><g:fieldValue bean="${eventInstance}" field="ticketStatus"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.ticket_url}">
				<li class="fieldcontain">
					<span id="ticket_url-label" class="property-label"><g:message code="event.ticket_url.label" default="Ticketurl" /></span>
					
						<span class="property-value" aria-labelledby="ticket_url-label"><g:fieldValue bean="${eventInstance}" field="ticket_url"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.venue}">
				<li class="fieldcontain">
					<span id="venue-label" class="property-label"><g:message code="event.venue.label" default="Venue" /></span>
					
						<span class="property-value" aria-labelledby="venue-label"><g:fieldValue bean="${eventInstance}" field="venue"/></span>
					
				</li>
				</g:if>

				<rateable:ratings bean='${eventInstance}'/>

				<comments:each bean="${eventInstance}">
				     ${comment.body} - Posted by ${comment.poster}
				</comments:each>

				<comments:render bean="${eventInstance}" />
			
			</ol>




			
			<!-- LIVESTREAM -->
  			<g:form name = "Start" url="[resource:eventInstance, action:'update']" method="PUT" >
  				<g:textField name="livestream" type="text" id="room-id" value="${eventInstance?.livestream}"/>
				
				  <div >
    				<g:actionSubmit id="open-room" class="save" action="update" value="Start" />
    			</div>
    		</g:form>

		    <button id="join-room">Join</button>
		    <button id="open-or-join-room">Auto Start or Join</button>
		    <!-- stream window -->
		    <div id="videos-container"></div>
		    <!-- room url -->
		    <div id="room-urls" style="display: none;"></div>


		    <!-- SPOTIFY -->
		    <div class="container">
			    <div id="results"></div>
			</div>
			<script id="results-template" type="text/x-handlebars-template">
			    {{#each albums.items}}
			    <div style="background-image:url({{images.0.url}})" data-album-id="{{id}}" class="cover"></div>
			    {{/each}}
			</script>


			<g:form url="[resource:eventInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${eventInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	

	<script src="http://cdnjs.cloudflare.com/ajax/libs/handlebars.js/2.0.0-alpha.1/handlebars.min.js"></script>
    <script src="${resource(dir:'js', file:'spotify.js')}" type="text/javascript"></script>

    
  </body>
</html>
