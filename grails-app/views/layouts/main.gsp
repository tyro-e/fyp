<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>
    <g:layoutTitle default="Grails" />
  </title>
  
  <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
  <!--
  <link rel="stylesheet" href="${resource(dir:'css/bootstrap',file:'bootstrap.css')}">
  -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">


  <script src="${resource(dir:'js/plugins/jQuery', file:'jQuery-v3.1.1.js')}" type="text/javascript"></script>
  <!--
  <script src="${resource(dir:'js/plugins/bootstrap', file:'bootstrap.js')}" type="text/javascript"></script>
  -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

  <g:layoutHead />  
</head>

<body>
  <div id="wrapper">
    <nav class="navbar navbar-inverse">
      <div class="container-fluid">

        <ul class="nav navbar-nav">
          <li><a class="" href="/fyp/">HOME</a></li>
          <li><g:link controller = "event">UPCOMING</g:link></li> 
          <li><g:link controller = "artist">ARTISTS</g:link></li>
          <li><g:link controller = "venue">VENUES</g:link></li> 


          <li style="float: right;">
            <sec:ifNotLoggedIn>
              <g:link controller = "login">
                <span>LOGIN</span>
              </g:link>
            </sec:ifNotLoggedIn>

            <sec:ifLoggedIn>
              <g:link controller = "logout">
                <span>LOGOUT</span>
              </g:link>
            </sec:ifLoggedIn>
          </li>

        </ul>
      </div>
    </nav>
   

    <div id="content">
      <g:layoutBody />
    </div>
  </div>
</body>
</html>