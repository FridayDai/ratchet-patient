<%@ page contentType="text/html;charset=UTF-8" %>
<g:set var="scriptPath" value="loginBundle" />
<g:set var="cssPath" value="login" />
<g:applyLayout name="main">
<html>
<head>
    <title>ratchet-v2-user-desktop</title>
</head>

<body>
    <div class="container">
        <h1 class="center">login in user desktop</h1>
        <g:form controller="authentication" action="login" class="form-center">
            <div class="center">
            <input type="text" name="username" placeholder="Username"  class="form-input">
            </div>

            <div class="center">
            <input type="password" name="password" placeholder="Password"  class="form-input">
            </div>

            <g:submitButton name="submit"></g:submitButton>
        </g:form>
    </div>
<div class="center">
    <g:if test="${errorMessage}">
    <p>${errorMessage}</p>
    </g:if>
</div>

</body>
</html>
</g:applyLayout>
