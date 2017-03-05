<html ng-app="myApp" ng-controller="BandsInTownController">
<head>
    <title>SUBSURFACE</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="utf-8">

    <!-- STYLESHEETS -->
    <link rel="stylesheet" href="${resource(dir:'css',file:'homepage-main.css')}" />
    <link rel="stylesheet" href="${resource(dir:'css/plugins',file:'bootstrap-datetimepicker.css')}" />
    <link rel="stylesheet" href="${resource(dir:'css/plugins',file:'fullcalendar.css')}" />
    <link rel="stylesheet" href="${resource(dir:'css/plugins',file:'fullcalendar.print.css')}" />
    <link rel="stylesheet" href="${resource(dir:'css/plugins',file:'pure.min.css')}" />
    <link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/grids-responsive-min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

    <!-- ANGULAR JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular.min.js"></script>
    <script src="https://code.angularjs.org/1.4.5/angular-route.js"></script> 

    <!-- GOOGLE FONTS -->
    <link href="https://fonts.googleapis.com/css?family=Bungee|Montserrat+Subrayada|Nunito|Poppins|Work+Sans" rel="stylesheet">
</head>

<body>
  <div class="content">
    <br>
      <div class="intro-body">
        <div class="container homepage-section1">




          <video muted="true" loop autoplay playsinline class="fullscreen-bg_video">
            <source src="https://s3-eu-west-1.amazonaws.com/fyp-subsurface/homepage/homepage-video.mp4" type="video/mp4">
          </video>

          <a href="#calendarModal" role="button" data-toggle="modal">
            <img class = "svg" id="calendarModalBtn" src="${resource(dir:'images/homepage', file: 'calendarIconSVG.svg')}">
          </a>

          <div class="homepage-top-main-container">
            <div class="row" style="margin-bottom: 15px;">
              <div class = "col-md-12">
                <div class="brand-heading" style="color: white;">SUBSURFACE</div>
                <p class="intro-text">ELECTRONIC MUSIC EVENTS <span style="color: red"> // </span> DUBLIN</p>
              </div>
            </div>

            <!--
            <div class="row">
                <div class = "col-md-9" style="float: none;margin: 0 auto;">
                  <div style="text-align: center;margin-top: 10px;">
                    <div class = "col-md-4"><button class = "mainpage-main-buttons" id = "main-buttons-date">DATE</button></div>
                    <div class = "col-md-4"><button class = "mainpage-main-buttons" id = "main-buttons-artist">ARTIST</button></div>
                    <div class = "col-md-4"><button class = "mainpage-main-buttons" id = "main-buttons-venue">VENUE</button></div>
                  </div>
                </div>
            </div>

            <div class="row">

              <div class = "col-md-9" style="float: none;margin: 0 auto;margin-top: 10px;overflow: hidden;">
                <div class = "col-md-4 mainpage-event-search main-date-picker" style="float: left;text-align: center;">
                  
                <div class="form-group" style="display: inline-flex;">
                  <div class='input-group date' id='datetimepicker1' style="width: 48%;">
                    <input type='text' class="form-control" style="padding: 6px 7px;height: 40px;" />
                    <span class="input-group-addon" style="height: 40px;">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                  </div>

                  <div style="width: 4%"></div>
                    <div class='input-group date' id='datetimepicker2' style="width: 48%;">
                      <input type='text' class="form-control" style="padding: 6px 7px;height: 40px;" />
                      <span class="input-group-addon" style="height: 40px">
                          <span class="glyphicon glyphicon-calendar"></span>
                      </span>
                    </div>
                  </div>
                </div>

                <div class="col-md-4 mainpage-event-search main-search-artist" style="text-align: center;">
                  <g:textField ng-model="search" ng-change="change()" onclick="select()" class = "artist-search" placeholder="Search artist.." name="query" value="${params.query}"/>
                </div>

                <div class="col-md-4 mainpage-event-search main-search-venue" style="float: right;text-align: center;">
                  <g:textField class = "venue-search" placeholder="Search venue.." name="query" value="${params.query}"/>
                </div>
              </div>
            </div>
            -->
          </div>

          <div class = "scroll-button-div">
            <a href="#scroll" style="color:transparent">
              <img id="scroll-to-arrow" src="https://www.viddyad.com/wp-content/uploads/2016/10/down-arrow.png" style="width: 50px;">
            </a>
          </div>
        
        <!-- REGISTER IF NOT LOGGED IN -->
        <sec:ifNotLoggedIn>
          <div class = "register-text" style="text-align: center;">New to the site? 
            <u style="cursor: pointer;color: rgba(255,255,255,0.4);">Register</u>
          </div>
        </sec:ifNotLoggedIn>
      </div>

        <!-- BEGIN PAGE CONTENT -->
        <div class="homepage-section2" id ="#scroll">
          <div class = "container row" style="width: 100%;margin-right: 0;margin-left: 0;padding-right: 0;padding-left: 0;">
            <!-- ANGULARJS RENDER: -->
            <div ng-view></div>
          </div>
        </div>

        </div>
      </div>
    </div>
  </div>
</div>  

<div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" style="padding: 12px">
      <div id='calendar'></div>
    </div>
  </div>
</div>

<!-- JS FILES -->
<script src="${resource(dir:'js/plugins', file:'bootstrap-datetimepicker.js')}" type="text/javascript"></script>
<script src="${resource(dir:'js/plugins', file:'moment.min.js')}" type="text/javascript"></script>
<script src="${resource(dir:'js/plugins', file:'fullcalendar.js')}" type="text/javascript"></script>
<script src="${resource(dir:'js', file:'homepage.js')}" type="text/javascript"></script>
<script src="${resource(dir:'js', file:'app.js')}" type="text/javascript"></script>

<!-- GOOGLE MAPS API -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBPPFxf8JyiTirmJeZvOWSW4z6NePOuEaU"></script>
</body>
</html>