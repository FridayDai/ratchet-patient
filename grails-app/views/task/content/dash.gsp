<%@ page contentType="text/html;charset=UTF-8" %>
<g:set var="scriptPath" value="taskBundle"/>
<g:set var="cssPath" value="task"/>
<g:applyLayout name="taskLayout">
	<html>
	<head>
		<title>The Disabilities of the Arm, Shoulder and Hand (DASH) Score</title>
	</head>

	<body>
	<div class="task-content">
		<div class="info container">Please rate your ability to do the following activities in the last week.</div>

		<div class="task-list-wrapper container">
			<g:each var="outcome" in="${contents}">
				<div class="question-list">
					<div class="question">${outcome.question}</div>
					<ul class="answer-list list grid horizontal-list">
						<li class="answer grid__col grid__col--1-of-5">
							<div class="text">No difficulty</div>
							<label class="choice">
								<input type="radio" class="rc-choice-hidden" name="${outcome.question}" value="Never"/>
								<span class="rc-radio"></span>
							</label>
						</li>
						<li class="answer grid__col grid__col--1-of-5">
							<div class="text">Mid difficulty</div>
							<label class="choice">
								<input type="radio" class="rc-choice-hidden" name="${outcome.question}" value="Rarely"/>
								<span class="rc-radio"></span>
							</label>
						</li>
						<li class="answer grid__col grid__col--1-of-5">
							<div class="text">Moderate difficulty</div>
							<label class="choice">
								<input type="radio" class="rc-choice-hidden" name="${outcome.question}" value="Sometimes"/>
								<span class="rc-radio"></span>
							</label>
						</li>
						<li class="answer grid__col grid__col--1-of-5">
							<div class="text">Severe difficulty</div>
							<label class="choice">
								<input type="radio" class="rc-choice-hidden" name="${outcome.question}" value="Often"/>
								<span class="rc-radio"></span>
							</label>
						</li>
						<li class="answer grid__col grid__col--1-of-5">
							<div class="text">Unable</div>
							<label class="choice">
								<input type="radio" class="rc-choice-hidden" name="${outcome.question}" value="Always"/>
								<span class="rc-radio"></span>
							</label>
						</li>
					</ul>
				</div>
			</g:each>
		</div>

		<div class="task-done-panel">
			<a class="task-done-btn" href="/task/result">I'm Done</a>
		</div>
	</div>
	</body>
	</html>
</g:applyLayout>
