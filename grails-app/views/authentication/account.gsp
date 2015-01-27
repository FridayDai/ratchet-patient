<%@ page contentType="text/html;charset=UTF-8" %>
<g:set var="scriptPath" value="" />
<g:set var="cssPath" value="account" />
<g:applyLayout name="main">
<html>
<head>
    <title>Account</title>
</head>

<body>
    <div class="container">
        <div class="row">
            <p><img src="${assetPath(src: 'grails_logo.png')}" alt=""/></p>
            <p>Powered by Ratchet Health</p>
            <p>Hi John Smith</p>
            <p>Welcome to Provider patient portal name！</p>
            <p>Please create your account below.</p>
        </div>
        <div class="register">
            <div class="item"><span class="field">Email:</span><input type="email"/></div>
            <div class="item"><span class="field">Password:</span><input type="password"/></div>
            <div class="item"><span class="field">Confirm Password:</span><input type="password"/></div>
        </div>
        <div class="row">
            <a class="btn" href="download">Create Account</a>
        </div>
    </div>
</body>
</html>
</g:applyLayout>
