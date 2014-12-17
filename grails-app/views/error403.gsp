<!DOCTYPE html>
<html>
<head>
  <title><g:if env="development">Grails Runtime Exception 403</g:if><g:else>Error</g:else></title>
  <meta name="layout" content="main">
  <g:if env="development"><asset:stylesheet src="errors.css"/></g:if>
</head>
<body>
<g:if env="development">
  <g:renderException exception="${exception}" />
</g:if>
<g:else>
  <ul class="errors">
    <li>Error403: An error has occurred</li>
  </ul>
</g:else>
</body>
</html>
