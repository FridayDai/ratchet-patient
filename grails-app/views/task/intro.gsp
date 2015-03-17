<g:set var="scriptPath" value="introBundle"/>
<g:set var="cssPath" value="task/intro"/>
<g:applyLayout name="taskLayout">
	<html>
	<head>
		<title>${Task.title}</title>
		<style type="text/css">
		.primary-color {
			color: ${  Task.color?:'#0f137d'  } !important;
		}

		.primary-border-color {
			border-color: ${  Task.color?:'#0f137d'  } !important;
		}

		.primary-background-color {
			background-color: ${  Task.color?:'#0f137d'  } !important;
		}

		.primary-hover-color:hover {
			color: #ffffff !important;
			background-color: ${  Task.color?:'#0f137d'  } !important;
		}
		</style>
	</head>

	<body>
	<div class="content container">
		%{--<div class="intro">INTRO</div>--}%

		%{--<div class="desc">${Task.description}</div>--}%

		<div class="phone">
			<p>Enter the last 4 digit of your phone #:</p>

			<form id="intro-form" action="${request.forwardURI.replaceFirst(/\/start$/, '')}/start" method="post">
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

	<div class="confirm-cover <g:if test="${errorMsg}">show</g:if>" id="confirm-cover"></div>

	<div class="confirm-container <g:if test="${errorMsg}">show</g:if>" id="confirm-container">
		<div class="confirm">
			<div class="confirm-header">
				<div class="confirm-title">Incorrect Number</div>

				<div class="confirm-content">The number you entered is incorrect. Please try again.</div>
			</div>

			<div class="confirm-footer">
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
