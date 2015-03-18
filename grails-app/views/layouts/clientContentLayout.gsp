<g:applyLayout name="main">
	<html>
	<head>
		<title><g:layoutTitle/></title>
		<g:layoutHead/>
	</head>

	<body>
	<div class="main">
		<div class="header">
			<div>
				<img class="client-logo" src="${client.logo}" alt="${client.portalName}"/>
			</div>

			<h1 style="color: ${client.primaryColorHex ?: '#0F137D'}">${client.portalName}</h1>

			<div class="sub-header">
				<span>Powered by</span>
				<img class="logo" src="${assetPath(src: 'Ratchet_Logo.png')}"/>
			</div>
		</div>

		<div class="body">
			<g:layoutBody/>
		</div>
	</div>
	</body>
	</html>
</g:applyLayout>
