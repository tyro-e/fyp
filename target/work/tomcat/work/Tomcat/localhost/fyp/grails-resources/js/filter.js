/*
$(window).bind("load", function ()
{
// A list of all unique HTML strings in links
var strings = [];

$( 'a' ).each( function recordContents(){
	console.log(strings);
  var $candidate = $( this );
  var text       = $candidate.text();

  // If the link's text isn't already in the `strings` array, 
  // it's the first of its kind: add it to the array and move on.
  if( strings.indexOf( text ) === -1 ){
    strings.push( text );
  }
  // If it is, it's a duplicate: remove it.
  else {
    $candidate.remove();
  }
} );
});

*/


var app = angular.module('myApp')


	app.filter('unique', function() 
	{
		console.log("RUNNING LAST?")

		return function(collection, keyname) 
	    {
	    	var output = [], keys = [];

	        angular.forEach(collection, function(item)
	        {
		        var key = item[keyname];
		        if(keys.indexOf(key) === -1) 
		        {
		            keys.push(key);
		            output.push(item);
	            }
	        });

	      return output;
	    };
	});
