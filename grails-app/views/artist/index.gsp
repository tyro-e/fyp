
<%@ page import="fyp.Artist" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'artist.label', default: 'Artist')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>

	    <script src="https://sdk.amazonaws.com/js/aws-sdk-2.1.12.min.js"></script>
	    <link rel="stylesheet" href="${resource(dir:'css',file:'post-page.css')}" />
	    <rateable:resources/>
	</head>

	<body>

	<div class="content">

		<!-- UPLOADED CONTENT -->
		<div class="col-md-12">
			<div class="content-banner">

			</div>
		</div>

		<div class="col-md-9">
			<div class="livestream-title">
		      <div class="livestream-artist">EXAMPLE ARTIST</div>
		      <div class="livestream-venue">LIVE<div style="color: red;display: inline-block;">AT</div>EXAMPLE VENUE</div>
		    </div>

		    <!-- RATE -->
		    
		    

			<!-- UPLOAD CONTENT -->
			<div class="upload-content">
				 <form action="http://s3.amazonaws.com/fyp-subsurface" method="post" enctype="multipart/form-data">
					<input type="text" name="key" value="testfile.txt" />
					<input type="text" name="acl" value="public-read" />
					<input type="text" name="content-type" value="text/plain" />
					<input type="hidden" name="AWSAccessKeyId" value="AKIAJT3UEF4EX5NSCN4A" />
					<input type="hidden" name="policy" value="ewogICJleHBpcmF0aW9uIjogIjIwMDktMDEtMDFUMTI6MDA6MDAuMDAwWiIsCiAgImNvbmRpdGlvbnMiOiBbCiAgICB7ImJ1Y2tldCI6ICJmeXAtc3Vic3VyZmFjZSIgfSwKICAgIHsiYWNsIjogInB1YmxpYy1yZWFkIiB9LAogICAgWyJlcSIsICIka2V5IiwgInRlc3RmaWxlLnR4dCJdLAogICAgWyJzdGFydHMtd2l0aCIsICIkQ29udGVudC1UeXBlIiwgInRleHQvIl0sCiAgXQp9Cg==" />
					<input type="hidden" name="signature" value="aGBe9LoxV0L4/yrnRpljNX1XSps=" />
					<input name="file" type="file" />
					<input name="submit" value="Upload" type="submit" />
				</form>
			</div>

			<!-- COMMENT -->
			<comments:each bean="${artist}">
    			 ${comment.body} - Posted by ${comment.poster}
			</comments:each>
		</div>



		<!-- SETLIST -->
		<div class="col-md-3">
			<div class="setlist-section">
				<form action="" id="add-track-form">
			      <fieldset>
			        <input type="text" class="song-title form-inputs" id="title" name="song-title" placeholder="Song Title" required>
			        <input type="text" class="song-key form-inputs" id="key" name="song-key" placeholder="Key" pattern="[A-Ga-g#♮]+">
			        <input type="number" min="1" max="350" class="song-tempo form-inputs" id="tempo" name="song-tempo" placeholder="BPM" >
			      </fieldset>
			      <button class="add-track-button" type="submit" form="add-track-form">Add</button>
			    </form>

			    <div class="setlist" id="sortable-setlist">
			    </div>
		    </div>
		</div>

	</div>


	<script src="https://rubaxa.github.io/Sortable/Sortable.js"></script>
	<script src="${resource(dir:'js/post-page', file:'setlist.js')}" type="text/javascript"></script>
	<script src="${resource(dir:'js/post-page', file:'main.js')}" type="text/javascript"></script>
	</body>

	<script type="text/javascript">
		def user = User.get(1)
def v = Vehicle.get(1)
v.addComment(user, "I prefer red cars")
 .addComment(user, "I prefer sporty cars")
	</script>
</html>
