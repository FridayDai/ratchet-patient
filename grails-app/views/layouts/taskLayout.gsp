<g:applyLayout name="main">
	<html>
	<head>
		<title><g:layoutTitle/></title>
		<g:layoutHead/>
	</head>

	<body>
	<g:render template="/shared/header" />

	<g:layoutBody/>
	<g:render template="/shared/googleAnalytics" />
	<g:pageProperty name="page.GA" />
	</body>
	</html>
</g:applyLayout>
