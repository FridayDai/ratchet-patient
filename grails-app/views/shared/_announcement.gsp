<g:set var="announcementService" bean="announcementService" />
<g:set var="announcement" value="${announcementService.checkAnnouncement()}" />
<g:if test="${announcement}">
	<div role="banner" class="maintenance" id="maintenance" style="background-color: ${announcement.colorHex?:'#fadedd'}">
		<div class="maintenance-content"><span class="maintenance-attention">Attention:</span> <span>${announcement.content}</span></div>
		<a href="#" id="maintenance-close" class="btn-close">X</a>
	</div>
</g:if>
