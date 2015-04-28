<g:set var="scriptPath" value="introBundle"/>
<g:set var="cssPath" value="task/intro"/>
<g:applyLayout name="taskLayout">
	<html>
	<head>
		<title>${Task.title}</title>
		<style type="text/css">
		.primary-color {
			color: ${client.primaryColorHex?:'#0f137d'} !important;
		}

		.primary-border-color {
			border-color: ${client.primaryColorHex?:'#0f137d'} !important;
		}

		.primary-background-color {
			background-color: ${client.primaryColorHex?:'#0f137d'} !important;
		}

		.primary-hover-color:hover {
			color: #ffffff !important;
			background-color: ${client.primaryColorHex?:'#0f137d'} !important;
		}
		</style>
	</head>

	<body>
	<div class="content container">
		%{--<div class="intro">INTRO</div>--}%
		<div class="intro">Your phone number is required for security purpose.</div>

		%{--<div class="desc">${Task.description}</div>--}%

		<div class="phone">
			<p>Enter the last 4 digit of your phone #:</p>

			<form id="intro-form" action="" method="post">
				<div class="form-control <g:if test="${errorMsg}">error</g:if>">
					<input type="text" name="last4Number" class="last-4-number" placeholder="Enter last 4 digits"
						   maxlength="4"/>
					<g:if test="${errorMsg}"><span class="rc-error-label">${errorMsg}</span></g:if>
				</div>
				<input type="submit"
					   class="rc-btn btn-start-task primary-color primary-border-color primary-hover-color"
					   value="Start"/>
			</form>
			%{--<span class="caret-left"></span>--}%

			<div class="tip primary-background-color">This link is unique to you and we ask for your phone number as added
			assurance that it is you who is accessing this survey.</div>
		</div>
	</div>

	<div class="mobile-alert-cover <g:if test="${errorMsg}">show</g:if>" id="mobile-alert-cover"></div>

	<div class="mobile-alert-container <g:if test="${errorMsg}">show</g:if>" id="mobile-alert-container">
		<div class="mobile-alert">
			<div class="mobile-alert-header">
				<div class="mobile-alert-title">Incorrect Number</div>

				<div class="mobile-alert-content">The number you entered is incorrect. Please try again.</div>
			</div>

			<div class="mobile-alert-footer">
				<button>OK</button>
			</div>
		</div>
	</div>
	</body>
	</html>

	<content tag="GA">
		<script>
			ga('send', 'event', '${taskTitle}', 'start', '${taskCode}');
		</script>
	</content>
</g:applyLayout>
