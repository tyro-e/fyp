
<%@ page import="fyp.Event" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-event" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
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
					
						<span class="property-value" aria-labelledby="artist-label"><g:fieldValue bean="${eventInstance}" field="artist"/></span>
					
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
			
			</ol>
			<g:form url="[resource:eventInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${eventInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
