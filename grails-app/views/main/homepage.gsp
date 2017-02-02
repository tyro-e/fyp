<html ng-app="app" ng-controller="BandsInTownController">
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> 
<!--<html lang="en" class="no-js">-->
<!--<![endif]-->
<head>
    <title>SUBSURFACE</title>
    <link rel="stylesheet" href="${resource(dir:'css',file:'homepage-main.css')}" />
    <link rel="stylesheet" href="${resource(dir:'css/plugins',file:'bootstrap-datetimepicker.css')}" />
    <link rel="stylesheet" href="${resource(dir:'css/plugins',file:'fullcalendar.css')}" />
    <link rel="stylesheet" href="${resource(dir:'css/plugins',file:'fullcalendar.print.css')}" />
</head>

<body>

  <div class="content">
    <br>
      <div class="intro-body">
        <div class="container homepage-section1">

          <a href="#calendarModal" role="button" data-toggle="modal">
            <img class = "svg" id="calendarModalBtn" src="${resource(dir:'images/homepage', file: 'calendarIconSVG.svg')}">
          </a>

          <div class="row" style="margin-bottom: 15px;">
            <div class = "col-md-12">
              <div class="brand-heading" style="color: white;">SUBSURFACE</div>
              <p class="intro-text">ELECTRONIC MUSIC EVENTS <span style="color: red"> // </span> DUBLIN</p>
            </div>
          </div>

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
                <g:textField class = "artist-search" placeholder="Search artist.." name="query" value="${params.query}"/>
              </div>

              <div class="col-md-4 mainpage-event-search main-search-venue" style="float: right;text-align: center;">
                <g:textField class = "venue-search" placeholder="Search venue.." name="query" value="${params.query}"/>
              </div>
            </div>
          </div>
        </div>

        <sec:ifNotLoggedIn>
          <div class = "register-text" style="text-align: center;">New to the site? <u style="cursor: pointer;color: rgba(255,255,255,0.4);">Register</u></div>
        </sec:ifNotLoggedIn>

          
        <!-- BEGIN PAGE CONTENT -->
        <div class="homepage-section2">
          <div class = "eventSectionTitle">EVENTS</div>

          <div class = "container row" style="width: 100%;">
            <div class="col-md-6" style="float: none;margin:0 auto;">
              <div class = "event-date" style="display: inline-flex;font-size: 24px;">
                FRIDAY <div style="color: red">  //  </div> JANUARY 13<span class="ordinal">TH</span> 2017
              </div>

              <div class = "event-item" style="height: 150px;border: 1px solid black;">
                <div class = "artist-name">
                  EXAMPLE ARTIST
                </div>

                <div class = "venue-name">
                  at Olympia Theatre
                </div>

                <div class = "attend-button" style="float: right;">
                  ATTEND
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- ANGULARJS RENDER -->
        <ng-view></ng-view>



        <!-- BANDSINTOWN PART -->
        <div class = "BandsInTownSection">
          <div class="content">
            <div class="pure-g pad_b20">
              <input type="text" ng-model="search" ng-change="change()" onclick="select()" class="pure-input" placeholder="Enter artist" autofocus />
            </div>
            <div class="pure-g">
              <div class="pure-u-1 pure-u-md-3-5">
                <div class="pure-g">
                  <div class="pure-u-1">
                    <div id="main-info" ng-include="'partials/main-info.html'"></div>
                  </div>
                  <div id="maps" class="pure-u-1">  
                    <div ng-include="'partials/maps.html'"></div>
                  </div>
                </div>      
              </div>
              <div id="shows" class="pure-u-1 pure-u-md-2-5 related-results">
                <div class="child">
                  <div id="related_results" ng-include="'partials/shows.html'"></div>
                </div>  
              </div>
            </div>  
          </div>
          <div class="pure-g" id="bottom_nav">
            <div class="pure-u-1 is-center">
              <a href="#!" id="bottom_nav_button" class="pure-button ticket-background"><i style="font-size:200%; height:50px;" class="fa fa-list"></i></a>
            </div>
          </div>


          <div ng-if="details.Response!=='False' && details != 'empty'">
            <div ng-if="details.length == 1">
              No shows for {{ search }}
            </div>

            <div ng-if="details.length > 1">
              Upcoming shows for {{ details[0].artists[0].name }}:<hr>
            </div>
            
            <ul class="rel-results">
              <li ng-repeat="show in details" ng-hide="$first">
                <a href="#" id="{{ $index + 1 }}" ng-click="update(show)">{{ show.formatted_datetime }}</a>
                <br>&nbsp;&nbsp;<span class="smaller">{{ show.venue.name }} | {{ show.formatted_location }}</span>
              </li>
            </ul>
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

<script type="text/javascript">
  angular.module('myApp', []).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider
    .when('/', {
        templateUrl: '../static/partials/index.html',   
        controller: BandsInTownController
    });
}]);
</script>

<script src="${resource(dir:'js/plugins', file:'bootstrap-datetimepicker.js')}" type="text/javascript"></script>
<script src="${resource(dir:'js/plugins', file:'moment.min.js')}" type="text/javascript"></script>
<script src="${resource(dir:'js/plugins', file:'fullcalendar.js')}" type="text/javascript"></script>
<script src="${resource(dir:'js', file:'homepage.js')}" type="text/javascript"></script>
<script src="${resource(dir:'js', file:'app.js')}" type="text/javascript"></script>
</body>
</html>