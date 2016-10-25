<%@ page import="fyp.Event" %>



<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'duration', 'error')} required">
	<label for="duration">
		<g:message code="event.duration.label" default="Duration" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="duration" type="number" min="0" value="${eventInstance.duration}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="event.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="description" required="" value="${eventInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'start', 'error')} required">
	<label for="start">
		<g:message code="event.start.label" default="Start" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="start" precision="day"  value="${eventInstance?.start}"  />
</div>

