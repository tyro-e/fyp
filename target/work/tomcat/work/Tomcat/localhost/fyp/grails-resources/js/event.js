$( document ).ready(function() 
{
    var ticketStatus = $('#ticketStatus').html();
    var length = ticketStatus.length;

    if (length < 24){
    	$('#ticketStatus').addClass('ticketsAvail');
    }
    else{
    	$('#ticketStatus').addClass('ticketsUnavail');
    }

});

$( document ).ready(function() 
{
    var ticketUrl = $('.ticketUrl').html();
    var link = $('#ticket_url_append');
    link.attr('href', ticketUrl);



    $(".commentable").insertAfter(".addComment");
});



$( document ).ready(function() 
{
	changeDate();
	getCurrentDate();
});

function changeDate(){
    var eventDate = document.getElementById('eventTime').innerText;
    console.log("event date json: " + eventDate);
    var newDate = new Date(eventDate);
    var dateConverted = newDate.toDateString();
    eventDate = dateConverted;
    console.log("event date normal: " + dateConverted);
    document.getElementById("eventTimeCorrect").append(dateConverted); 


    var currentDate = new Date()
    var JSONCurrentDate = currentDate.toJSON()

    console.log("json current date: " + JSONCurrentDate);
    console.log("current date normal: " + currentDate);

    if (eventDate > JSONCurrentDate)
    {
      console.log("event date is after current date")
      // HIDE RATING
      $('#rating_rating').css('display', 'none');
      $('#rating_form').css('display', 'none');
      $('#rating_notifytext').css('display','none');

    }

    if (eventDate < JSONCurrentDate)
    {
      console.log("event date is before current date")

    }

    
}

function getCurrentDate()
{

}







 function buildMap()
 {
    var longitude2 = ("longitude").innerHtml();
    var latitude2 = ("latitude").innerHtml();
    var venue2 = ("venue-name").innerHtml();

    console.log(longitude2);
    console.log(latitude2);
    console.log(venue2);

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
        scrollwheel: false,
        disableDefaultUI: true,
        
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
      //map.set('styles', mapStyle);
    }
    else{
      removeMap();
    }
  }