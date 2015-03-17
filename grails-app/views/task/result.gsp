<g:set var="cssPath" value="task/result"/>
<g:applyLayout name="taskLayout">
	<html>
	<head>
		<title>${Task.title}</title>

		<style type="text/css">
		@media only screen and (max-width: 767px) {
			.task-time {
				color: ${Task.color?:'#0f137d'} !important;
			}
		}

		.primary-color {
			color: ${Task.color?:'#0f137d'} !important;
		}

		.primary-border-color {
			border-color: ${Task.color?:'#0f137d'} !important;
		}

		.primary-background-color {
			background-color: ${Task.color?:'#0f137d'} !important;
		}
		</style>
	</head>

	<body>
	<div class="result-content">
		<div class="container clear">
			<div class="top">
				<div class="para1 primary-color">COMPLETED!</div>

				<div class="para2">Thank you for completing the task!</div>
				%{--<p class="para3">The Disabilities of the Arm, Shoulder and Hand (DASH) Score is:</p>--}%
				%{--<p class="para4">29.92</p>--}%
			</div>
			%{--<div class="bottom">--}%
			%{--<p class="reminder">Click here to create an account on Proliance Patient portal name to manage your tasks and view their result.</p>--}%
			%{--<a class="btn-create-account">Create Account</a>--}%
			%{--</div>--}%
		</div>
	</div>
	</body>
	</html>
	<content tag="GA">
		<script>
			ga('send', 'event', '${taskTitle}', 'complete', '${taskCode}');
		</script>
	</content>
</g:applyLayout>
