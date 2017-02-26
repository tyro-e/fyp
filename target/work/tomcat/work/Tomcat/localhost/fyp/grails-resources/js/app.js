'use strict';

var app = angular.module('myApp', ['ngRoute']);

app.config(['$routeProvider', function($routeProvider) 
{
  $routeProvider.when('/', { templateUrl: 'assets/app/views/index.html' })
}]);
  
app.controller('BandsInTownController', function($scope, $http){
  var pendingTask;
  var search = $scope.search;

  // sets the search scope if undefined - (on page load)
  if($scope.search === undefined){
    $scope.search = "";
    fetch();
  }



  $scope.change = function(){
    if($scope.search != ""){
      console.log("change: " + $scope.search);
      if(pendingTask){
        clearTimeout(pendingTask);
      }
      pendingTask = setTimeout(fetch, 500);
    }
    else{
      removeMap();
      $scope.details = "empty";
    }
  };


  function fetch(){ 
    console.log("fetch: " + $scope.search);
             
    if($scope.search == "" || $scope.search == null){
      $.getJSON("http://api.bandsintown.com/events/search.json?&api_version=2.0&app_id=FYP&location=Dublin,Ireland", function(result) 
      {
        $scope.$apply(function()
        {
          console.log("fetching 1");
          $scope.details = result;
        }, 0);

        buildMap();   
      });    
    }

    else{
      console.log("fetch: " + $scope.search);

      // search the API based on user input
      $.getJSON("http://api.bandsintown.com/artists/" + $scope.search + "/events/search.json?&api_version=2.0&app_id=FYP&location=Dublin,Ireland", function(result) 
      {
        $scope.$apply(function()
        {
          console.log("fetching 2");
          $scope.details = result;
        }, 0);

        // remove the map if no artist was found
        if(result[0] === undefined){
          removeMap();
          fetch();
        }

        else{
          buildMap();
        }       
      });   
    } 
  }

  
  function buildMap(){
    console.log("buildMap");
    // building the content within the info window
    var contentString = "<strong>" + $scope.details[0].title + "</strong><br>&nbsp;<span>" + $scope.details[0].formatted_datetime + "</span>";

    var mapStyle = [
      {
        featureType: "administrative",
        elementType: "labels",
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "poi",
        elementType: "labels",
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "water",
        elementType: "labels",
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "road",
        elementType: "labels",
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "transit",
        elementType: "labels",
        stylers: [
          { visibility: "off" }
        ]
      }
    ]

    if($scope.details[0].ticket_url !== null){
      contentString += "&nbsp;&nbsp;<a href='" + $scope.details[0].ticket_url + "' target='_blank' class='pure-button'>Tickets <i class='fa fa-ticket'></i></a>";
    }
    // setting map attributes
    $scope.map = {
      latitude: $scope.details[0].venue.latitude,
      longitude: $scope.details[0].venue.longitude,
      venue: $scope.details[0].venue.name,
    }

    // making sure latitude and longitude exist before attempting to map
    if($scope.map.latitude !== undefined || null && $scope.map.longitude !== undefined || null){
      var map;
      var myLatLng = {lat: $scope.map.latitude, lng: $scope.map.longitude};
      
      // centering & zoom level of map
      map = new google.maps.Map(document.getElementById('map'), {     
        center: myLatLng,
        zoom: 17,
        scrollwheel: false
      });  
      
      // building the content within the infowindow
      var infowindow = new google.maps.InfoWindow({
        content: contentString
      });
      
      // setting the attibutes for the map marker
      var marker = new google.maps.Marker({
        position: myLatLng,
        map: map,
        title: $scope.map.venue
      });
      
      // creating an event listener for the map marker
      marker.addListener('click', function(){
        infowindow.open(map, marker);
      });
      
      marker.setMap(map);
      map.set('styles', mapStyle);
    }
    else{
      removeMap();
    }
  }
  
  function removeMap(){
    console.log("removeMap");
    // remove the map and it's background color
    var map = document.getElementById("map");
    map.innerHTML = "";
    map.style.background = "";
  }

  $scope.update = function(band){
    console.log("update");

    // sort the array by date desc
    $scope.details.sort(function(a,b){
      var c = new Date(a.datetime);
      var d = new Date(b.datetime);
      return c-d; 
    });

    // pull the selected show out of the array of shows
    for(var i = 0; i < $scope.details.length; i++){
      if(band.id == $scope.details[i].id){
        $scope.details.splice(i, 1);
      }
    }

    // put the selected show first in the array of shows
    $scope.details.unshift(band);
    
    buildMap();
  };

  $scope.select = function(){
    console.log("select");
    this.setSelectionRange(0, this.value.length);
  }
});
