<%@ page contentType="text/html;charset=UTF-8" %>
<g:set var="scriptPath" value="" />
<g:set var="cssPath" value="patient" />
<g:applyLayout name="main">
<html>
<head>
    <title>Patient</title>
</head>

<body>
    <div class="sidebar">
        <div class="info">
            <img src="${assetPath(src: 'grails_logo.png')}" alt=""/>
            <p>Patient Portal Name</p>
            <p>Powered by RatchetHealth</p>
        </div>
        <div class="nav">
            <ul class="navbar">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle">Rotator Cuff</a>
                    <div class="divider"></div>
                    <ul class="dropdown-menu">
                        <li><a href="#">Tasks</a></li>
                        <li><a href="#">Care Team</a></li>
                        <li><a href="#">Library(Future)</a></li>
                    </ul>
                </li>
                <li>Total Knee Replacement</li>
            </ul>
        </div>
        <div class="name">Mr. Patient</div>
    </div>
</body>
</html>
</g:applyLayout>
