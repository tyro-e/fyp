<%@ page import="org.grails.s3.S3Asset" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="refresh" content="2">
    <meta name="layout" content="main"/>
    <title>S3Asset List</title>
</head>
<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${resource(dir: '')}">Home</a></span>
    <span class="menuButton"><g:link class="create" action="create">Upload New Asset</g:link></span>
</div>
<div class="body">
    <h1>S3 Asset List</h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="list">
        <table>
            <thead>
            <tr>

                <g:sortableColumn property="id" title="Id"/>

                <g:sortableColumn property="key" title="Key"/>

                <g:sortableColumn property="status" title="Status"/>

                <g:sortableColumn property="title" title="Title"/>

                <g:sortableColumn property="description" title="Description"/>

                <g:sortableColumn property="mimeType" title="Mime Type"/>

                <g:sortableColumn property="length" title="File length bytes"/>

                <g:sortableColumn property="localPath" title="Local Path"/>

            </tr>
            </thead>
            <tbody>
            <g:each in="${s3AssetList}" status="i" var="s3Asset">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                    <td><g:link action="show" id="${s3Asset.id}">${s3Asset.id?.encodeAsHTML()}</g:link></td>

                    <td>${s3Asset.key?.encodeAsHTML()}</td>

                    <td>${s3Asset.status?.encodeAsHTML()}</td>

                    <td>${s3Asset.title?.encodeAsHTML()}</td>

                    <td>${s3Asset.description?.encodeAsHTML()}</td>

                    <td>${s3Asset.mimeType?.encodeAsHTML()}</td>

                    <td>${s3Asset.length?.encodeAsHTML()}</td>

                    <td>${s3Asset.localPath?.encodeAsHTML()}</td>

                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
    <div class="paginateButtons">
        <g:paginate total="${S3Asset.count()}"/>
    </div>
</div>
</body>
</html>
