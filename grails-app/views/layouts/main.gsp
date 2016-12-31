<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title><g:layoutTitle default="Grails" /></title>
  <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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