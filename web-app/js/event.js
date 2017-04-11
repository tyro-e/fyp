$(document).ready(function() 
{
  changeDate();
  buildMap();
});

$(document).ready(function() 
{
    var ticketStatus = $('#ticketStatus').html();
    var length = ticketStatus.length;

    console.log(ticketStatus);
    console.log(length)

    if (length <= 30){
    	$('#ticketStatus').addClass('ticketsAvail');
      $('.ticketStatusDiv').css('display','none');
    }
    else{
    	$('#ticketStatus').addClass('ticketsUnavail');
      $('.ticketLinkDiv').css('display','none');
    }
});

$(document).ready(function() 
{
    var ticketUrl = $('.ticketUrl').html();
    var link = $('#ticket_url_append');
    link.attr('href', ticketUrl);

    $(".commentable").insertAfter(".addComment");
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

    console.log("current date json: " + JSONCurrentDate);
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

 function buildMap()
 {
    var longitude  = parseFloat(document.getElementById("longitude").innerHTML);
    var latitude = parseFloat(document.getElementById("latitude").innerHTML);
    var venue = document.getElementById('venueName').innerText;
    var myLatLng = {lat: latitude, lng: longitude};
    var map;
      
    // centering & zoom level of map
    map = new google.maps.Map(document.getElementById('map'), 
    {     
      center: myLatLng,
      zoom: 15,
      scrollwheel: false,
      disableDefaultUI: true
    });  
    
    var marker = new google.maps.Marker({
      position: myLatLng,
      map: map,
      title: venue
    });
    
    marker.addListener('click', function(){
      infowindow.open(map, marker);
    });
    
    marker.setMap(map);
}