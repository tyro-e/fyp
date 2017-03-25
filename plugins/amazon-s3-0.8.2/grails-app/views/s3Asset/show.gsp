  
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Show S3Asset</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Asset List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">Upload New Asset</g:link></span>
        </div>
        <div class="body">
            <h1>Show S3Asset</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Id:</td>
                            
                            <td valign="top" class="value">${s3Asset.id}</td>
                            
                        </tr>

                         <tr class="prop">
                            <td valign="top" class="name">Key:</td>

                            <td valign="top" class="value">${s3Asset.key}</td>

                        </tr>

                    
                        <tr class="prop">
                            <td valign="top" class="name">Asset:</td>
                            
                            <td valign="top" class="value"><a href="<s3:createLinkTo asset='${s3Asset}'/>"><s3:createLinkTo asset='${s3Asset}'/></a></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Title:</td>
                            
                            <td valign="top" class="value">${s3Asset.title}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Description:</td>
                            
                            <td valign="top" class="value">${s3Asset.description}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Mime Type</td>
                            
                            <td valign="top" class="value">${s3Asset?.mimeType}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Status:</td>
                            
                            <td valign="top" class="value">${s3Asset.status}</td>
                            
                        </tr>


                        <tr class="prop">
                          <td valign="top" class="name">File length bytes:</td>

                          <td valign="top" class="value">${s3Asset.length}</td>

                        </tr>



                        <tr class="prop">
                            <td valign="top" class="name">Local Path:</td>

                            <td valign="top" class="value">${s3Asset.localPath}</td>

                        </tr>
                    
                    </tbody>
                </table>
            </div>

            <div class="buttons">
                <g:form controller="s3Asset">
                    <input type="hidden" name="id" value="${s3Asset?.id}" />
                    <span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </g:form>
            </div>
            <div style="margin-top: 10px" class="dialog">
                <img src="<s3:createLinkTo asset='${s3Asset}'/>" alt=""/>
            </div>
        </div>
    </body>
</html>
