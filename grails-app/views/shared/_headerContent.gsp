<g:if test="${announcement?.status == 'active'}">
	<div role="banner" class="maintenance ${announcement.background}">
		<span class="attention">Attention:</span> ${announcement.announcement}
		<a href="#" id="maintenance-close" class="btn-close"> </a>
	</div>
</g:if>

<div class="main-header primary-border-color clear">
    <a class="nav-info" href="/">
        <img src="${client.logo}" alt="" class="primary-border-color"/>

        <p class="primary-color">${client.portalName}</p>
    </a>
    <span class="copy-right">
        <span class="distance">Powered By</span>
        <img class="logo" src="${assetPath(src: 'Ratchet_Logo.png')}"/>
    </span>
</div>
