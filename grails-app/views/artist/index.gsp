
<%@ page import="fyp.Artist" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'artist.label', default: 'Artist')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>

	    <script src="https://sdk.amazonaws.com/js/aws-sdk-2.1.12.min.js"></script>

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


		 <form action="http://s3.amazonaws.com/fyp-subsurface" method="post" enctype="multipart/form-data">
			<input type="text" name="key" value="testfile.txt" />
			<input type="text" name="acl" value="public-read" />
			<input type="text" name="content-type" value="text/plain" />
			<input type="hidden" name="AWSAccessKeyId" value="AKIAJT3UEF4EX5NSCN4A" />
			<input type="hidden" name="policy" value="ewogICJleHBpcmF0aW9uIjogIjIwMDktMDEtMDFUMTI6MDA6MDAuMDAwWiIsCiAgImNvbmRpdGlvbnMiOiBbCiAgICB7ImJ1Y2tldCI6ICJmeXAtc3Vic3VyZmFjZSIgfSwKICAgIHsiYWNsIjogInB1YmxpYy1yZWFkIiB9LAogICAgWyJlcSIsICIka2V5IiwgInRlc3RmaWxlLnR4dCJdLAogICAgWyJzdGFydHMtd2l0aCIsICIkQ29udGVudC1UeXBlIiwgInRleHQvIl0sCiAgXQp9Cg==" />
			<input type="hidden" name="signature" value="aGBe9LoxV0L4/yrnRpljNX1XSps=" />
			<input name="file" type="file" />
			<input name="submit" value="Upload" type="submit" />
			</form>
	</body>
</html>
