
<%@ page import="fyp.Venue" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'venue.label', default: 'Venue')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-venue" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-venue" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list venue">
			
				<g:if test="${venueInstance?.venueName}">
				<li class="fieldcontain">
					<span id="venueName-label" class="property-label"><g:message code="venue.venueName.label" default="Venue Name" /></span>
					
						<span class="property-value" aria-labelledby="venueName-label"><g:fieldValue bean="${venueInstance}" field="venueName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${venueInstance?.venueDescription}">
				<li class="fieldcontain">
					<span id="venueDescription-label" class="property-label"><g:message code="venue.venueDescription.label" default="Venue Description" /></span>
					
						<span class="property-value" aria-labelledby="venueDescription-label"><g:fieldValue bean="${venueInstance}" field="venueDescription"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${venueInstance?.venueAddress}">
				<li class="fieldcontain">
					<span id="venueAddress-label" class="property-label"><g:message code="venue.venueAddress.label" default="Venue Address" /></span>
					
						<span class="property-value" aria-labelledby="venueAddress-label"><g:fieldValue bean="${venueInstance}" field="venueAddress"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${venueInstance?.alcoholServed}">
				<li class="fieldcontain">
					<span id="alcoholServed-label" class="property-label"><g:message code="venue.alcoholServed.label" default="Alcohol Served" /></span>
					
						<span class="property-value" aria-labelledby="alcoholServed-label"><g:formatBoolean boolean="${venueInstance?.alcoholServed}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${venueInstance?.capacity}">
				<li class="fieldcontain">
					<span id="capacity-label" class="property-label"><g:message code="venue.capacity.label" default="Capacity" /></span>
					
						<span class="property-value" aria-labelledby="capacity-label"><g:fieldValue bean="${venueInstance}" field="capacity"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${venueInstance?.events}">
				<li class="fieldcontain">
					<span id="events-label" class="property-label"><g:message code="venue.events.label" default="Events" /></span>
					
						<g:each in="${venueInstance.events}" var="e">
						<span class="property-value" aria-labelledby="events-label"><g:link controller="event" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:venueInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${venueInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
