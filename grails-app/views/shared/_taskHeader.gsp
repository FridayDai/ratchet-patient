<div class="header">
	<g:render template="/shared/headerContent"></g:render>
	<div class="sub-header primary-border-color">
		<p class="primary-color">${Task.title}</p>

		<div class="task-time"><span>DUE:</span> <g:formatDate date="${new java.util.Date(Task.dueTime)}"
															   timeZone="${TimeZone.getTimeZone('America/Vancouver')}"
															   format="MMM d, yyyy h:mm a"></g:formatDate></div>
		<div class="tips">
			<asset:image src="tip.png" class="primary-background-color"></asset:image>
			<span class="tip-content">Losing weight enhances your chance of recovery.</span>
		</div>
	</div>

</div>
