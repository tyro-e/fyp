
$(document).ready(function() 
{
links = []
$('.anchor a:first-child').each(function() {
    links.append([$(this).text, $(this)]);
});

grouped = _.groupBy(links, function(input){return input[0]});

for (var i=0;i<grouped.size;i++){
  if (grouped[i].size > 1){
   grouped[i][0][1].remove()
  }
}
});