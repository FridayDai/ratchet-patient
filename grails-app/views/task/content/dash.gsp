<%@ page contentType="text/html;charset=UTF-8" %>
<g:set var="scriptPath" value="taskBundle"/>
<g:set var="cssPath" value="task/content/dash"/>
<g:applyLayout name="taskLayout">
	<html>
	<head>
		<title>${Task.title}</title>

		<style type="text/css">
		@media only screen and (max-width: 767px) {
			.task-time {
				color: ${Task.color?:'#0f137d'} !important;
			}

			.task-content .question {
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

		.task-done-btn {
			color: ${Task.color?:'#0f137d'} !important;
			border-color: ${Task.color?:'#0f137d'} !important;;
		}

		.task-done-btn:hover {
			color: #ffffff !important;
			background-color: ${Task.color?:'#0f137d'} !important;
		}
		.rc-choice-hidden:checked + .rc-radio:before, .rc-radio:hover:before {
			background-color: ${Task.color?:'#0f137d'} !important;
		}
		</style>
	</head>

	<body>
	<div class="dash task-content">
		<div class="info container">${Task.description}</div>

		<form action="${request.forwardURI.replaceFirst(/\/start$/, '/complete')}" method="post">
			<input type="hidden" name="code" value="${code}"/>

			<div class="task-list-wrapper container">
				<g:each var="section" in="${Task.sections}">
					<div class="section-title">${section.title}</div>
					<g:each var="question" in="${section.questions}">
						<div class="question-list">
							<div class="question">${question.order}. ${question.title}</div>

							<div class="answer-list answer-list-${question.order}">
								<ul class="list horizontal-list">
									<g:each var="choice" in="${question.choices}">
										<li class="answer">
											<div class="text">${choice.content}</div>
											<label class="choice">
												<input type="radio" class="rc-choice-hidden"
													   name="choices.${question.id}" value="${choice.sequence}"/>
												<span class="rc-radio"></span>
											</label>
										</li>
									</g:each>
								</ul>
							</div>
						</div>
					</g:each>
				</g:each>
			</div>

			<div class="task-done-panel">
				<input type="submit" class="rc-btn task-done-btn" value="I'm Done">
			</div>
		</form>
	</div>
	</body>
	</html>
</g:applyLayout>
