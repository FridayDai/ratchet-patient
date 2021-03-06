<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title><g:layoutTitle default="Patient Portal"/></title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="shortcut icon" href="${client?.favIcon ?: assetPath(src: 'favicon.ico')}" type="image/x-icon">
  <link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
  <link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">
  <g:if test="${cssPath}">
    <asset:stylesheet src="css/pages/${cssPath}"/>
  </g:if>
  <g:layoutHead/>
</head>

<body>
<div class="main-wrapper">
<g:layoutBody/>
</div>
<g:render template="/shared/copyRight"/>
<g:if test="${scriptPath}">
  <asset:javascript src="bundles/${scriptPath}"/>
</g:if>
</body>
</html>
