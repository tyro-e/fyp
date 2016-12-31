
<%@ page import="fyp.Venue" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'venue.label', default: 'Venue')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-venue" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-venue" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="venueName" title="${message(code: 'venue.venueName.label', default: 'Venue Name')}" />
					
						<g:sortableColumn property="venueDescription" title="${message(code: 'venue.venueDescription.label', default: 'Venue Description')}" />
					
						<g:sortableColumn property="venueAddress" title="${message(code: 'venue.venueAddress.label', default: 'Venue Address')}" />
					
						<g:sortableColumn property="alcoholServed" title="${message(code: 'venue.alcoholServed.label', default: 'Alcohol Served')}" />
					
						<g:sortableColumn property="capacity" title="${message(code: 'venue.capacity.label', default: 'Capacity')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${venueInstanceList}" status="i" var="venueInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${venueInstance.id}">${fieldValue(bean: venueInstance, field: "venueName")}</g:link></td>
					
						<td>${fieldValue(bean: venueInstance, field: "venueDescription")}</td>
					
						<td>${fieldValue(bean: venueInstance, field: "venueAddress")}</td>
					
						<td><g:formatBoolean boolean="${venueInstance.alcoholServed}" /></td>
					
						<td>${fieldValue(bean: venueInstance, field: "capacity")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${venueInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
