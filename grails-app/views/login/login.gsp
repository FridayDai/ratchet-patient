<%--
  Created by IntelliJ IDEA.
  User: colin
  Date: 12/12/14
  Time: 6:04 PM
--%>

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
        <g:form controller="logout" action="index" class="form-center">
            <div class="center">
            <input type="text" placeholder="Email Address"  class="form-input">
            </div>

            <div class="center">
            <input type="password" placeholder="Password"  class="form-input">
            </div>

            <g:submitButton name="submit"></g:submitButton>
        </g:form>
    </div>

</body>
</html>
</g:applyLayout>
