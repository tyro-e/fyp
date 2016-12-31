
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
			
				<g:if test="${eventInstance?.livestream}">
				<li class="fieldcontain">
					<span id="livestream-label" class="property-label"><g:message code="event.livestream.label" default="Livestream" /></span>
					
						<span class="property-value" aria-labelledby="livestream-label"><g:formatBoolean boolean="${eventInstance?.livestream}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.eventTime}">
				<li class="fieldcontain">
					<span id="eventTime-label" class="property-label"><g:message code="event.eventTime.label" default="Event Time" /></span>
					
						<span class="property-value" aria-labelledby="eventTime-label"><g:formatDate date="${eventInstance?.eventTime}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.price}">
				<li class="fieldcontain">
					<span id="price-label" class="property-label"><g:message code="event.price.label" default="Price" /></span>
					
						<span class="property-value" aria-labelledby="price-label"><g:fieldValue bean="${eventInstance}" field="price"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.artists}">
				<li class="fieldcontain">
					<span id="artists-label" class="property-label"><g:message code="event.artists.label" default="Artists" /></span>
					
						<g:each in="${eventInstance.artists}" var="a">
						<span class="property-value" aria-labelledby="artists-label"><g:link controller="artist" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
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
