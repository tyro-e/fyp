
<%@ page import="fyp.Event" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-event" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-event" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="bandsintown_id" title="${message(code: 'event.bandsintown_id.label', default: 'Bandsintownid')}" />
					
						<g:sortableColumn property="artist" title="${message(code: 'event.artist.label', default: 'Artist')}" />
					
						<g:sortableColumn property="ticketStatus" title="${message(code: 'event.ticketStatus.label', default: 'Ticket Status')}" />
					
						<g:sortableColumn property="ticket_url" title="${message(code: 'event.ticket_url.label', default: 'Ticketurl')}" />
					
						<g:sortableColumn property="venue" title="${message(code: 'event.venue.label', default: 'Venue')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${eventInstanceList}" status="i" var="eventInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${eventInstance.id}">${fieldValue(bean: eventInstance, field: "bandsintown_id")}</g:link></td>
					
						<td>${fieldValue(bean: eventInstance, field: "artist")}</td>
					
						<td>${fieldValue(bean: eventInstance, field: "ticketStatus")}</td>
					
						<td>${fieldValue(bean: eventInstance, field: "ticket_url")}</td>
					
						<td>${fieldValue(bean: eventInstance, field: "venue")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${eventInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
