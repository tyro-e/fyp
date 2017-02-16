(function ($){
  
    $(function (){
      doResponsive();
      $(window).resize(function () {
          doResponsive();
      });
    });
    // checking the screen width and adjusting content shown
    function doResponsive (){
      if ( $(window).width() <= 767 ) {
         if(!$("#shows").hasClass("hidden") && !$("#maps").hasClass("hidden")){
          $("#shows").addClass('hidden');
         }
      } 
      else {
        $("#shows").removeClass('hidden');
        $("#maps").removeClass('hidden');
      }
    }
    
    // toggling between the map view and the list of shows
    $("#bottom_nav_button").click(function(){
      if($("#shows").hasClass('hidden')){
        $("#shows").removeClass('hidden');
        $("#maps").addClass('hidden');
        $("#bottom_nav_button").empty();
        $("#bottom_nav_button").html('<i style="font-size:200%; height:50px;" class="fa fa-globe"></i>');
      }
      else{
        $("#maps").removeClass('hidden');
        $("#shows").addClass('hidden');
        $("#bottom_nav_button").empty();
        $("#bottom_nav_button").html('<i style="font-size:200%; height:50px;" class="fa fa-list"></i>');
      }   
    });

})(jQuery);
