<g:applyLayout name="main">
	<html>
	<head>
		<title><g:layoutTitle/></title>
		<g:layoutHead/>
	</head>

	<body>
	<g:render template="/shared/taskHeader" />

	<g:layoutBody/>
    <g:if test="${hasAssistMe && patientId}">
        <div class="assist-bottom">
            <g:link target="_blank" class="assist-mobile-btn" controller="assist" action="index" params="[patientId: patientId]">
                Assist Me</g:link>
        </div>

    </g:if>
	<g:render template="/shared/googleAnalytics" />
	<g:pageProperty name="page.GA" />
	</body>
	</html>
</g:applyLayout>
