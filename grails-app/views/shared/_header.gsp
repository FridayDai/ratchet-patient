<div class="header">
	<div class="main-header primary-border-color clear">
		<a class="nav-info" href="/">
			<img src="${Task.logo}" alt="" class="primary-border-color"/>

			<p class="primary-color">${Task.portalName}</p>
		</a>
		<span class="copy-right">
			<span class="distance">Powered By</span>
			<img src="${assetPath(src: 'logo.png')}"/>
			<span class="bold">RATCHET</span>
			<span>HEALTH</span>
		</span>
	</div>

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
