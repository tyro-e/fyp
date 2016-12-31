
<%@ page import="fyp.Artist" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'artist.label', default: 'Artist')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-artist" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-artist" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="artistName" title="${message(code: 'artist.artistName.label', default: 'Artist Name')}" />
					
						<g:sortableColumn property="artistGenre" title="${message(code: 'artist.artistGenre.label', default: 'Artist Genre')}" />
					
						<g:sortableColumn property="artistDescription" title="${message(code: 'artist.artistDescription.label', default: 'Artist Description')}" />
					
						<g:sortableColumn property="artistNationality" title="${message(code: 'artist.artistNationality.label', default: 'Artist Nationality')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${artistInstanceList}" status="i" var="artistInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${artistInstance.id}">${fieldValue(bean: artistInstance, field: "artistName")}</g:link></td>
					
						<td>${fieldValue(bean: artistInstance, field: "artistGenre")}</td>
					
						<td>${fieldValue(bean: artistInstance, field: "artistDescription")}</td>
					
						<td>${fieldValue(bean: artistInstance, field: "artistNationality")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${artistInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
