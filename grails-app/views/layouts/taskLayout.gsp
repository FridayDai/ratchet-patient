<g:applyLayout name="main">
	<html>
	<head>
		<title><g:layoutTitle/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0"/>
		<g:layoutHead/>
	</head>

	<body>
	<div class="main-container">
	<g:render template="/shared/taskHeader" />

	<g:layoutBody/>
    <g:if test="${hasAssistMe && patientId}">
        <div class="assist-bottom">
            <g:link target="_blank" class="assist-mobile-btn" controller="assist" action="index" params="[patientId: patientId]">
                Assist Me</g:link>
        </div>

    </g:if>
	</div>
	<g:render template="/shared/googleAnalytics" />
	<g:pageProperty name="page.GA" />
	</body>
	</html>
</g:applyLayout>
