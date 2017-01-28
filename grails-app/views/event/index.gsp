<!--
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
					
						<g:sortableColumn property="livestream" title="${message(code: 'event.livestream.label', default: 'Livestream')}" />
					
						<g:sortableColumn property="eventTime" title="${message(code: 'event.eventTime.label', default: 'Event Time')}" />
					
						<g:sortableColumn property="price" title="${message(code: 'event.price.label', default: 'Price')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${eventInstanceList}" status="i" var="eventInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${eventInstance.id}">${fieldValue(bean: eventInstance, field: "livestream")}</g:link></td>
					
						<td><g:formatDate date="${eventInstance.eventTime}" /></td>
					
						<td>${fieldValue(bean: eventInstance, field: "price")}</td>
					
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
-->


<!DOCTYPE html>
<html lang="en" ng-app="Angular-API" ng-controller="BandsInTownController">
  <head>
    <title ng-bind="'BandsInTown - ' + search">BandsInTown</title>
    <link rel="stylesheet" href="${resource(dir:'css/upcoming',file:'pure.min.css')}" />
    <link rel="stylesheet" href="${resource(dir:'css/upcoming',file:'style.css')}" />
    <link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/grids-responsive-min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="utf-8">
  </head>

  <body>
    <div class="pure-menu pure-menu-horizontal pure-menu-scrollable">
      <a class="pure-menu-heading" href="#"><b>BandsInTown</b> <span class="span-style">Search Tour Schedules</span></a>
    </div>     
   
    <noscript>
      <div class="nojs">Javascript is either disabled or not supported in your browser. Please enable it or use a Javascript enabled browser.</div>
    </noscript>
    
    <div class="content">
      <div class="pure-g pad_b20">
        <input type="text" ng-model="search" ng-change="change()" onclick="select()" class="pure-input" placeholder="Enter band or artist" autofocus />
      </div>
      <div class="pure-g">
        <div class="pure-u-1 pure-u-md-3-5">
          <div class="pure-g">
            <div class="pure-u-1">
            	<g:render template = "upcoming/main-info"/>
              <!--<div id="main-info" ng-include="'partials/main-info.html'"></div>-->
            </div>
            <div id="maps" class="pure-u-1">  
            	<g:render template = "upcoming/maps"/>
              <!--<div ng-include="'partials/maps.html'"></div>-->
            </div>
          </div>      
        </div>
        <div id="shows" class="pure-u-1 pure-u-md-2-5 related-results">
          <div class="child">
          	<g:render template = "upcoming/shows"/>
            <!--<div id="related_results" ng-include="'partials/shows.html'"></div>-->
          </div>  
        </div>
      </div>  
    </div>
    <div class="pure-g" id="bottom_nav">
      <div class="pure-u-1 is-center">
        <a href="#!" id="bottom_nav_button" class="pure-button ticket-background"><i style="font-size:200%; height:50px;" class="fa fa-list"></i></a>
      </div>
    </div>
    <script src="${resource(dir:'js/upcoming', file:'angular.min.js')}" type="text/javascript"></script>
	<script src="${resource(dir:'js/upcoming', file:'app.js')}" type="text/javascript"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="${resource(dir:'js/upcoming', file:'nav_menu.js')}" type="text/javascript"></script>

    <script src="https://maps.googleapis.com/maps/api/js?key=ADD_IN_OWN_KEY!!"></script>
  </body>
</html>
