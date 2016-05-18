<div class="main-header primary-border-color clear">
    <a id="logo-link" class="nav-info" href="/">
        <img src="${client.logo}" alt="" class="client-logo primary-border-color"/>

        <p class="primary-color">${client.portalName}</p>
    </a>
    <span class="copy-right">
        <span class="distance">Powered By</span>
        <img class="logo" src="${assetPath(src: 'Ratchet_Logo_grey.png')}"/>
        <g:if test="${hasAssistMe && patientId}">
            <g:link target="_blank" class="assist-btn" controller="assist" action="index" params="[patientId: patientId]">
                Assist Me</g:link>
        </g:if>
    </span>
</div>
