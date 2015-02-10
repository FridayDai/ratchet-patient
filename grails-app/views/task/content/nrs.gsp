<%@ page contentType="text/html;charset=UTF-8" %>
<g:set var="scriptPath" value="taskBundle"/>
<g:set var="cssPath" value="task/content/nrs"/>
<g:applyLayout name="taskLayout">
	<html>
	<head>
		<title>Outcome</title>
	</head>

	<body>
	<div class="nrs task-content">
		<div class="info container">${Task.description}</div>
		<div class="description">
			<p>0 = No Pain</p>
			<p>1-3 = Mild Pain (nagging, annoying, interfering little with activities of daily living)</p>
			<p>4-6 = Moderate Pain (interferes significantly with activities of daily living)</p>
			<p>7-10 = Severe Pain (disabling; unable to perform activities of daily living)</p>
		</div>

		<form>
			<div class="task-list-wrapper container">
				<g:each var="question" in="${Task.questions}" status="i">
					<div class="question-list">
						<div class="question">${raw(question.title)}</div>

						<div class="answer-list">
							<ul class="list">
								<g:each var="j" in="${ (0..<11) }">
									<li class="answer">
										<div class="text"></div>
										<label class="choice-number choice-number-${j}">
											<input type="radio" class="rc-choice-number-hidden" name="${question.id}"
												   value="j"/>
											<span class="rc-radio"></span>
										</label>
									</li>
								</g:each>
							</ul>
						</div>
					</div>
				</g:each>
			</div>

			<div class="task-done-panel">
				<a class="task-done-btn" href="/task/result">I'm Done</a>
			</div>
		</form>
	</div>
	</body>
	</html>
</g:applyLayout>
