  
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Edit S3Asset</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Asset List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">Upload New Asset</g:link></span>
        </div>
        <div class="body">
            <h1>Edit S3Asset</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${s3Asset}">
            <div class="errors">
                <g:renderErrors bean="${s3Asset}" as="list" />
            </div>
            </g:hasErrors>
            <g:form controller="s3Asset" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${s3Asset?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>


                            <tr class='prop'>
                                <td valign='top' class='name'>
                                    <label for='key'>Key:</label>
                                </td>
                                <td valign='top'>
                                    ${fieldValue(bean:s3Asset,field:'key')}
                                </td>
                            </tr>
                            
                            <tr class='prop'>
                                <td valign='top' class='name'>
                                    <label for='localPath'>File to Upload:</label>
                                </td>
                                <td valign='top' class='value ${hasErrors(bean:s3Asset,field:'localPath','errors')}'>
                                    <input type="file" name="myFile" />
                                </td>
                            </tr>


                            <tr class='prop'>
                                <td valign='top' class='name'>
                                    <label for='title'>Title:</label>
                                </td>
                                <td valign='top' class='value ${hasErrors(bean:s3Asset,field:'title','errors')}'>
                                    <input type="text" id='title' name='title' value="${fieldValue(bean:s3Asset,field:'title')}"/>
                                </td>
                            </tr>

                            <tr class='prop'>
                                <td valign='top' class='name'>
                                    <label for='description'>Description:</label>
                                </td>
                                <td valign='top' class='value ${hasErrors(bean:s3Asset,field:'description','errors')}'>
                                    <input type="text" id='description' name='description' value="${fieldValue(bean:s3Asset,field:'description')}"/>
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" value="Update" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
