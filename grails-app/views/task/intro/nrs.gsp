<g:set var="scriptPath" value="introBundle"/>
<g:set var="cssPath" value="task/intro"/>
<g:applyLayout name="taskLayout">
	<html>
	<head>
		<title>${Task.title}</title>
	</head>

	<body>
	<div class="content container">
		<div class="intro">INTRO</div>

		<div class="desc">${Task.description}</div>

		<div class="sub-desc">
			<p>0 = No Pain</p>

			<p>1-3 = Mild Pain (nagging, annoying, interfering little with activities of daily living)</p>

			<p>4-6 = Moderate Pain (interferes significantly with activities of daily living)</p>

			<p>7-10 = Severe Pain (disabling; unable to perform activities of daily living)</p>
		</div>

		<div class="phone">
			<p>Enter the last 4 digit of your phone #:</p>

			<form id="intro-form" aciton="." method="post">
				<div class="form-control">
					<input type="text" name="last4Number" class="last-4-number" placeholder="Enter last 4 digits"/>
				</div>
				<input type="submit" class="btn btn-start-task" value="Start"/>
			</form>
			<span class="caret-left"></span>

			<div class="tip">Sorry for the inconvenience, this is required in order for us to help you protect your data.</div>
		</div>
	</div>

	<div class="confirm-cover" id="confirm-cover"></div>

	<div class="confirm-container" id="confirm-container">
		<div class="confirm">
			<div class="confirm-header">
				<div class="confirm-title">Incorrect Password</div>

				<div class="confirm-content">The password you entered is incorrect. Please try again.</div>
			</div>

			<div class="confirm-footer">
				<button>OK</button>
			</div>
		</div>
	</div>
	</body>
	</html>
</g:applyLayout>