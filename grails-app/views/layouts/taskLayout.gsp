<g:applyLayout name="main">
	<html>
	<head>
		<title><g:layoutTitle/></title>
		<g:layoutHead/>
	</head>

	<body>
	<g:render template="/shared/taskHeader" />

	<g:layoutBody/>
	<g:if test="${scriptPath}">
		<asset:javascript src="bundles/${scriptPath}"/>
	</g:if>
	<g:render template="/shared/googleAnalytics" />
	<g:pageProperty name="page.GA" />
	</body>
	</html>
</g:applyLayout>
