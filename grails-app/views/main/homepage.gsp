<!DOCTYPE html>
<html>
<head>
    <title>SUBSURFACE</title>
    <link rel="stylesheet" href="${resource(dir:'css',file:'homepage-main.css')}" />
    <link rel="stylesheet" href="${resource(dir:'css/plugins',file:'bootstrap-datetimepicker.css')}" />
    <link rel="stylesheet" href="${resource(dir:'css/plugins',file:'fullcalendar.css')}" />
    <link rel="stylesheet" href="${resource(dir:'css/plugins',file:'fullcalendar.print.css')}" media='print' />
</head>

<body>

  <div class="content">
    <br>
      <div class="intro-body">
        <div class="container homepage-top">
          <div class="row">

            <div class = "col-md-12">
              <div class="brand-heading" style="color: white;">SUBSURFACE</div>
              <p class="intro-text">ELECTRONIC MUSIC EVENTS <span style="color: red"> // </span> DUBLIN</p>
            </div>
          </div>

          <div class="row">
              <div class = "col-md-6" style="float: none;margin: 0 auto;">
                <div style="text-align: center;margin-top: 10px;">
                  <div class = "col-md-4"><button class = "mainpage-main-buttons" id = "main-buttons-event">EVENT</button></div>
                  <div class = "col-md-4"><button class = "mainpage-main-buttons" id = "main-buttons-artist">ARTIST</button></div>
                  <div class = "col-md-4"><button class = "mainpage-main-buttons" id = "main-buttons-venue">VENUE</button></div>
                </div>
              </div>
          </div>

          <div class="row">

            <div class = "col-md-6" style="float: none;margin: 0 auto;margin-top: 10px;overflow: hidden;">
              <div class = "col-md-4 mainpage-event-search main-date-picker" style="float: left;text-align: center;">
                
                <div class="container">
                  <div class="form-group">
                      <div class='input-group date' id='datetimepicker1'>
                          <input type='text' class="form-control" />
                          <span class="input-group-addon">
                              <span class="glyphicon glyphicon-calendar"></span>
                          </span>
                      </div>
                  </div>

                  <div class="form-group">
                      <div class='input-group date' id='datetimepicker2'>
                          <input type='text' class="form-control" />
                          <span class="input-group-addon">
                              <span class="glyphicon glyphicon-calendar"></span>
                          </span>
                      </div>
                  </div>
                </div>
              </div>

              <div class="col-md-4 mainpage-event-search main-search-artist" style="text-align: center;">
                <g:textField class = "artist-search" placeholder="Search artist.." name="query" value="${params.query}"/>
              </div>

              <div class="col-md-4 mainpage-event-search main-search-venue" style="float: right;text-align: center;">
                <g:textField class = "venue-search" placeholder="Search venue.." name="query" value="${params.query}"/>
              </div>
            </div>

          </div>



          <a href="#calendarModal" role="button" data-toggle="modal">
            <img id="calendarModalBtn" src="${resource(dir:'images/homepage', file: 'calendarIconWhite.png')}">
          </a>

        </div>



        <sec:ifNotLoggedIn>
          <div class = "register-text" style="text-align: center;">New to the site? <u style="cursor: pointer;color: rgba(255,255,255,0.4);">Register</u></div>
        </sec:ifNotLoggedIn>

          
        <!-- Begin page content -->
        <div class="section2" style="padding-bottom: 1000px;background-color: white;">
          <div class = "eventListings">
            <div class = "eventSectionTitle">EVENTS</div>
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







<script src="${resource(dir:'js/plugins', file:'bootstrap-datetimepicker.js')}" type="text/javascript"></script>
<script src="${resource(dir:'js/plugins', file:'moment.min.js')}" type="text/javascript"></script>
<script src="${resource(dir:'js/plugins', file:'fullcalendar.js')}" type="text/javascript"></script>
<script src="${resource(dir:'js', file:'homepage.js')}" type="text/javascript"></script>
</body>
</html>