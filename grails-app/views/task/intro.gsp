<g:set var="scriptPath" value="introBundle"/>
<g:set var="cssPath" value="task/intro"/>
<g:applyLayout name="taskLayout">
	<html>
	<head>
		<title>Task Introduction</title>
	</head>

	<body>
	<div class="content container">
		<div class="intro">INTRO</div>

		<div class="desc">${Task.description}</div>

		<div class="phone">
			<p>Enter the last 4 digit of your phone #:</p>
			<form id="intro-form" aciton="." method="post">
				<input type="text" name="last4Number" class="last-4-number" placeholder="Enter last 4 digits"/>
				<input type="submit" class="btn btn-start-task" value="Start"/>
			</form>
			<span class="caret-left"></span>

			<div class="tip">Sorry for the inconvenience, this is required in order for us to help you protect your data.</div>

		</div>
	</div>
	</body>
	</html>
</g:applyLayout>
