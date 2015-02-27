<%@ page contentType="text/html;charset=UTF-8" %>
<g:set var="cssPath" value="email/confirm"/>
<g:applyLayout name="emailLayout">
	<html>
	<head>
		<title>Email Confirmation</title>
		<style type="text/css">
		.primary-color {
			color: ${client.color} !important;
		}

		.primary-border-color {
			border-color: ${client.color} !important;
		}
		</style>
	</head>

	<body>
	<div class="email-content content">
		<h1 class="client-name primary-color primary-border-color">${client.portalName}</h1>

		<p class="message primary-color primary-border-color">E-mail confirmed. Thank you!</p>
		%{--<button>Ok</button>--}%
	</div>
	</body>
	</html>
</g:applyLayout>
