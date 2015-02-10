<div class="header clear">
        <a class="nav-info" href="/">
            <img src="${assetPath(src: 'patient_portal_logo.png')}" alt=""/>
            <p>PROLIANCE PATIENT PORTAL</p>
        </a>
        <span class="copy-right">
            <span class="distance">Powered By</span>
            <img src="${assetPath(src: 'logo.png')}" />
            <span class="bold">RATCHET</span>
            <span>HEALTH</span>
        </span>
</div>
<div class="sub-header">
    <p>${Task.title}</p>
    <div class="task-time"><span>DUE:</span> <g:formatDate date="${new java.util.Date(Task.dueTime)}" format="MMM / d / yyyy, h:mm:ssa"></g:formatDate></div>
</div>
