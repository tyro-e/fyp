<%@ page import="fyp.Venue" %>



<div class="fieldcontain ${hasErrors(bean: venueInstance, field: 'venueName', 'error')} required">
	<label for="venueName">
		<g:message code="venue.venueName.label" default="Venue Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="venueName" required="" value="${venueInstance?.venueName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: venueInstance, field: 'venueDescription', 'error')} ">
	<label for="venueDescription">
		<g:message code="venue.venueDescription.label" default="Venue Description" />
		
	</label>
	<g:textField name="venueDescription" value="${venueInstance?.venueDescription}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: venueInstance, field: 'venueAddress', 'error')} required">
	<label for="venueAddress">
		<g:message code="venue.venueAddress.label" default="Venue Address" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="venueAddress" required="" value="${venueInstance?.venueAddress}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: venueInstance, field: 'alcoholServed', 'error')} ">
	<label for="alcoholServed">
		<g:message code="venue.alcoholServed.label" default="Alcohol Served" />
		
	</label>
	<g:checkBox name="alcoholServed" value="${venueInstance?.alcoholServed}" />
</div>

<div class="fieldcontain ${hasErrors(bean: venueInstance, field: 'capacity', 'error')} required">
	<label for="capacity">
		<g:message code="venue.capacity.label" default="Capacity" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="capacity" type="number" value="${venueInstance.capacity}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: venueInstance, field: 'events', 'error')} ">
	<label for="events">
		<g:message code="venue.events.label" default="Events" />
		
	</label>
	<g:select name="events" from="${fyp.Event.list()}" multiple="multiple" optionKey="id" size="5" value="${venueInstance?.events*.id}" class="many-to-many"/>
</div>

