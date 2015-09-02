<div class="header" id="header">
	<g:render template="/shared/announcement" />
	<g:render template="/shared/headerContent"/>
	<div class="sub-header primary-border-color">
		<p class="primary-color">${Task.title}</p>

		<div class="task-time primary-color"><span>Due Date:</span> <g:formatDate date="${new java.util.Date(Task.dueTime)}"
															   timeZone="${TimeZone.getTimeZone('America/Vancouver')}"
															   format="MMM d, yyyy" /></div>
        <g:if test="${!noTips}">
            <div class="tips">
                <asset:image src="tip.png" class="primary-background-color" />
                <span class="tip-content">Losing weight enhances your chance of recovery.</span>
            </div>
        </g:if>

	</div>

</div>
