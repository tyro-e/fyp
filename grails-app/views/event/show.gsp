<%@ page import="fyp.Event" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		
		<link rel="stylesheet" href="${resource(dir:'css',file:'livestream.css')}" />
		<rateable:resources/>
		
	</head>
	<body>
		<a href="#show-event" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-event" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list event">
			
				<g:if test="${eventInstance?.bandsintown_id}">
				<li class="fieldcontain">
					<span id="bandsintown_id-label" class="property-label"><g:message code="event.bandsintown_id.label" default="Bandsintownid" /></span>
					
						<span class="property-value" aria-labelledby="bandsintown_id-label"><g:fieldValue bean="${eventInstance}" field="bandsintown_id"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.artist}">
				<li class="fieldcontain">
					<span id="artist-label" class="property-label"><g:message code="event.artist.label" default="Artist" /></span>
					
						<span class="property-value" aria-labelledby="artist-label"><g:fieldValue bean="${eventInstance}" field="artist"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.ticketStatus}">
				<li class="fieldcontain">
					<span id="ticketStatus-label" class="property-label"><g:message code="event.ticketStatus.label" default="Ticket Status" /></span>
					
						<span class="property-value" aria-labelledby="ticketStatus-label"><g:fieldValue bean="${eventInstance}" field="ticketStatus"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.ticket_url}">
				<li class="fieldcontain">
					<span id="ticket_url-label" class="property-label"><g:message code="event.ticket_url.label" default="Ticketurl" /></span>
					
						<span class="property-value" aria-labelledby="ticket_url-label"><g:fieldValue bean="${eventInstance}" field="ticket_url"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.venue}">
				<li class="fieldcontain">
					<span id="venue-label" class="property-label"><g:message code="event.venue.label" default="Venue" /></span>
					
						<span class="property-value" aria-labelledby="venue-label"><g:fieldValue bean="${eventInstance}" field="venue"/></span>
					
				</li>
				</g:if>

				<rateable:ratings bean='${eventInstance}'/>

				<comments:each bean="${eventInstance}">
				     ${comment.body} - Posted by ${comment.poster}
				</comments:each>

				<comments:render bean="${eventInstance}" />
			
			</ol>




			
			
			<g:formRemote name = "Start" url="[resource:eventInstance, action:'update']" method="PUT" >
				<g:textField name="livestream" type="text" id="room-id" value="${eventInstance?.livestream}"/>
				
				<div id="open-room">
    				<g:actionSubmit class="save" action="update" value="Start" />
    			</div>
    		</g:formRemote>




		    <button id="join-room">Join</button>
		    <button id="open-or-join-room">Auto Start or Join</button>
		    
		    <!-- LIVESTREAM WINDOW -->
		    <div id="videos-container"></div>

		    <!-- ROOM URL -->
		    <div id="room-urls" style="display: none;"></div>











			<g:form url="[resource:eventInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${eventInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	

	<script src="${resource(dir:'js/livestream', file:'RTCMultiConnection.js')}" type="text/javascript"></script>
    <script src="${resource(dir:'js/livestream', file:'socket.io.js')}" type="text/javascript"></script>

    <script>
      // UI Code
      document.getElementById('open-room').onclick = function()
      {
        disableInputButtons();
        connection.sdpConstraints.mandatory = {
            OfferToReceiveAudio: false, OfferToReceiveVideo: false
        };
        connection.open(document.getElementById('room-id').value, function() {
            showRoomURL(connection.sessionid);
        });
      };

      document.getElementById('join-room').onclick = function() 
      {
        disableInputButtons();
        connection.sdpConstraints.mandatory = {
            OfferToReceiveAudio: true, OfferToReceiveVideo: true
        };
        connection.join(document.getElementById('room-id').value);
      };

      document.getElementById('open-or-join-room').onclick = function() 
      {
        disableInputButtons();
        connection.openOrJoin(document.getElementById('room-id').value, function(isRoomExists, roomid) {
          if(!isRoomExists) 
          {
              showRoomURL(roomid);
          }
        });
      };

      // RTCMultiConnection Code
      var connection = new RTCMultiConnection();

      // socket.io server is assumed to be deployed on own URL
      connection.socketURL = '/';
      // comment-out below line if no socket.io server
      connection.socketURL = 'https://rtcmulticonnection.herokuapp.com:443/';
      connection.socketMessageEvent = 'video-broadcast-demo';
      connection.session = 
      {
        audio: true,
        video: true,
        oneway: true
      };

      connection.videosContainer = document.getElementById('videos-container');

      connection.onstream = function(event) 
      {
        connection.videosContainer.appendChild(event.mediaElement);
        event.mediaElement.play();
        setTimeout(function() 
        {
          event.mediaElement.play();
        }, 5000);
      };

      function disableInputButtons()
      {
        document.getElementById('open-or-join-room').disabled = true;
        document.getElementById('open-room').disabled = true;
        document.getElementById('join-room').disabled = true;
        document.getElementById('room-id').disabled = true;
      }

      // Handling Room-ID
      function showRoomURL(roomid) {
        var roomHashURL = '#' + roomid;
        var roomQueryStringURL = '?roomid=' + roomid;
        var html = ' ';
        html += 'Hash URL: <a href="' + roomHashURL + '" target="_blank">' + roomHashURL + '</a>';
        html += '<br>';
        html += 'QueryString URL: <a href="' + roomQueryStringURL + '" target="_blank">' + roomQueryStringURL + '</a>';
        var roomURLsDiv = document.getElementById('room-urls');
        roomURLsDiv.innerHTML = html;
        roomURLsDiv.style.display = 'block';
      }

      (function() 
      {
        var params = {}, r = /([^&=]+)=?([^&]*)/g;

        function d(s) {
          return decodeURIComponent(s.replace(/\+/g, ' '));
        }

        var match, search = window.location.search;

        while (match = r.exec(search.substring(1)))
            params[d(match[1])] = d(match[2]);

        window.params = params;
      })();

      var roomid = '';

      if (localStorage.getItem(connection.socketMessageEvent)) {
        roomid = localStorage.getItem(connection.socketMessageEvent);
      } 

      else {
        roomid = connection.token();
      }

      document.getElementById('room-id').value = roomid;
      document.getElementById('room-id').onkeyup = function() {
        localStorage.setItem(connection.socketMessageEvent, this.value);
      };

      var hashString = location.hash.replace('#', '');

      if(hashString.length && hashString.indexOf('comment-') == 0) {
        hashString = '';
      }

      var roomid = params.roomid;

      if(!roomid && hashString.length) {
        roomid = hashString;
      }

      if(roomid && roomid.length) 
      {
        document.getElementById('room-id').value = roomid;
        localStorage.setItem(connection.socketMessageEvent, roomid);
        // auto-join-room
        (function reCheckRoomPresence() {
          connection.checkPresence(roomid, function(isRoomExists) {
            if(isRoomExists) {
              connection.join(roomid);
              return;
            }
            setTimeout(reCheckRoomPresence, 5000);
          });
        })();

        disableInputButtons();
      }
    </script>


   </body>
</html>
