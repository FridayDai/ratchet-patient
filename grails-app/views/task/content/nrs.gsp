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

		<form action="./complete" method="post">
			<input type="hidden" name="code" value="${code}"/>
			<div class="task-list-wrapper container">
				<g:each var="question" in="${Task.questions}" status="i">
					<div class="question-list">
						<div class="question">${raw(question.title)}</div>

						<div class="answer-list">
							<div class="answer-description">
								<span class="no-pain">No Pain</span>
								<span class="severe-pain">Severe Pain</span>
							</div>
							<ul class="list">
								<g:each var="j" in="${ (0..<11) }">
									<li class="answer">
										<div class="text">
											${j} -
											<g:if test="${j == 0}">No Pain</g:if>
											<g:if test="${j >= 1 && j < 4}">Mid Pain</g:if>
											<g:if test="${j >= 4 && j < 7}">Moderate Pain</g:if>
											<g:if test="${j >= 7 && j < 11}">Severe Pain</g:if>
										</div>
										<label class="choice choice-number choice-number-${j}">
											<input type="radio" class="rc-choice-hidden" name="choices.${question.id}"
												   value="${j}"/>
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
				<input type="submit" class="task-done-btn" value="I'm Done" />
			</div>
		</form>
	</div>
	</body>
	</html>
</g:applyLayout>
