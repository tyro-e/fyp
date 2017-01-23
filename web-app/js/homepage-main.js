$(document).ready(function()
{
	$('.mainpage-main-buttons').click(function()
	{
		$(this).toggleClass('main-buttons-active');
	});
});

$(document).ready(function()
{
	$('#main-buttons-artist').click(function()
	{
		$('.main-search-artist').toggleClass('search-options-display');
		console.log("rev");
	});

	$('#main-buttons-venue').click(function()
	{
		$('.main-search-venue').toggleClass('search-options-display');
	});
});



// Date picker
$(document).ready(function(){
    $(".form_datetime").datetimepicker({

        viewMode: "days",
        format: "dd/MM/yyyy",
        autoclose: true,
        todayBtn: true
    });
});


// Calendar Modal
$(document).ready(function () {
    $("#myBtn").click(function(){
    	
        $('#myModal').modal('show');
    });
});

$(document).ready(function() {
	$('#calendar').fullCalendar({
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month,basicWeek,basicDay'
		},
		defaultDate: '2016-12-12',
		navLinks: true, // can click day/week names to navigate views
		editable: true,
		eventLimit: true, // allow "more" link when too many events
		events: [
			{
				title: 'All Day Event',
				start: '2016-12-01'
			},
			{
				title: 'Long Event',
				start: '2016-12-07',
				end: '2016-12-10'
			},
			{
				id: 999,
				title: 'Repeating Event',
				start: '2016-12-09T16:00:00'
			},
			{
				id: 999,
				title: 'Repeating Event',
				start: '2016-12-16T16:00:00'
			},
			{
				title: 'Conference',
				start: '2016-12-11',
				end: '2016-12-13'
			},
			{
				title: 'Meeting',
				start: '2016-12-12T10:30:00',
				end: '2016-12-12T12:30:00'
			},
			{
				title: 'Lunch',
				start: '2016-12-12T12:00:00'
			},
			{
				title: 'Meeting',
				start: '2016-12-12T14:30:00'
			},
			{
				title: 'Happy Hour',
				start: '2016-12-12T17:30:00'
			},
			{
				title: 'Dinner',
				start: '2016-12-12T20:00:00'
			},
			{
				title: 'Birthday Party',
				start: '2016-12-13T07:00:00'
			},
			{
				title: 'Click for Google',
				url: 'http://google.com/',
				start: '2016-12-28'
			}
		]
	});
});