<%@ page contentType="text/html;charset=UTF-8" %>
<g:set var="cssPath" value="email/confirm"/>
<g:applyLayout name="emailLayout">
    <html>
    <head>
        <title>Email Confirmation</title>
        <style type="text/css">
        .primary-color {
            color: ${              client.color              } !important;
        }

        .primary-border-color {
            border-color: ${              client.color              } !important;
        }
        </style>
    </head>

    <body>
    <div class="email-content content">

        <a class="nav-info" href="/">
            <img src="${client.logo}" alt="" class="primary-border-color"/>

            <p class="client-name primary-color primary-border-color">${client.portalName}</p>
        </a>
        <span class="copy-right">
            <span class="distance">Powered By</span>
            <img class="logo" src="${assetPath(src: 'Ratchet_Logo.png')}"/>
        </span>


        %{--<h1 class="client-name primary-color primary-border-color">${client.portalName}</h1>--}%

        %{--<span class="copy-right">--}%
        %{--<span class="distance">Powered By</span>--}%
        %{--<img class="logo" src="${assetPath(src: 'Ratchet_Logo.png')}"/>--}%
        %{--</span>--}%

        %{--<p class="message primary-color primary-border-color">E-mail confirmed. Thank you!</p>--}%
        %{--<button>Ok</button>--}%
    </div>

    <div class="middle-content">
        <p class="message">E-mail confirmed. Thank you!</p>
    </div>

    <div class="bottom-content">

    </div>
    </body>
    </html>
</g:applyLayout>
