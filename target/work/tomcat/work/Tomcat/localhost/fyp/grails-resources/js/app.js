//= require jQuery
//= require_tree .
//= require_self

'use strict';
var app = angular.module('myApp', ['ngRoute']);


app.config(['$routeProvider', function($routeProvider) 
{
  $routeProvider.when('/', { templateUrl: 'assets/app/views/index.html' })
}]);

  
app.controller('BandsInTownController', function($scope, $http){
  var pendingTask;
  // sets the search scope if undefined - (on page load)
  if($scope.search === undefined){
    console.log($scope.search);
    $scope.search = "AFI";
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
    // search the API based on user input
    $.getJSON("http://api.bandsintown.com/artists/" + $scope.search + "/events.json?&api_version=2.0&callback=?&app_id=test_project", function(result) 
    {
      $scope.$apply(function()
      {
         console.log("fetching");
        $scope.details = result;
        console.log(result);
      }, 0);
      // remove the map if no artist was found
      if(result[0] === undefined){
        removeMap();
      }
      // make sure the map is showing with checkMap and then build the map
      else{
        checkMap();
        buildMap();
      }       
    });       
  }
  
  function checkMap(){
    console.log("checkMap");
    // checking the width of the screen
    // if the screen is < 768 the code will make sure the map is showing and the list of shows are hidden
    var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
    if(width < 768){
      var maps = angular.element(document.querySelector("#maps"));
      if(maps.hasClass('hidden')){
        var shows = angular.element(document.querySelector("#shows"));
        var button = document.getElementById("bottom_nav_button");
        maps.removeClass('hidden');
        shows.addClass('hidden');
        button.innerHTML = '<i style="font-size:200%; height:50px;" class="fa fa-list"></i>';
      }
    }
  }
  
  function buildMap(){
    console.log("buildMap");
    // building the content within the infowindow
    var contentString = "<strong>" + $scope.details[0].title + "</strong><br>&nbsp;<span>" + $scope.details[0].formatted_datetime + "</span>";
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
        zoom: 11
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
    // check to see if the layout is on mobile
    checkMap();
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
    // build the map of the new show
    buildMap();
  };

  $scope.select = function(){
    console.log("select");
    this.setSelectionRange(0, this.value.length);
  }
});
