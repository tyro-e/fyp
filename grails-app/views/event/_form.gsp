<%@ page import="fyp.Event" %>



<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'livestream', 'error')} ">
	<label for="livestream">
		<g:message code="event.livestream.label" default="Livestream" />
		
	</label>
	<g:checkBox name="livestream" value="${eventInstance?.livestream}" />
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'eventTime', 'error')} required">
	<label for="eventTime">
		<g:message code="event.eventTime.label" default="Event Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="eventTime" precision="day"  value="${eventInstance?.eventTime}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'price', 'error')} required">
	<label for="price">
		<g:message code="event.price.label" default="Price" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="price" value="${fieldValue(bean: eventInstance, field: 'price')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'artists', 'error')} ">
	<label for="artists">
		<g:message code="event.artists.label" default="Artists" />
		
	</label>
	<g:select name="artists" from="${fyp.Artist.list()}" multiple="multiple" optionKey="id" size="5" value="${eventInstance?.artists*.id}" class="many-to-many"/>
</div>

