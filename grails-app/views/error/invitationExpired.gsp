<!DOCTYPE html>

<g:set var="cssPath" value="error/error"/>
<g:applyLayout name="error">
    <html>
    <head>
        <title>Invitation Expired</title>
        <style type="text/css">
        .primary-color {
            color: ${       client.primaryColorHex?:'#0f137d'       } !important;
        }
        </style>
    </head>

    <body>
    <div class="error-body expire-body">

        <div class="middle-content invite-expire-top primary-color">Confirmation Link Expired</div>

        <div class="text-font invite-expire-middle primary-color">Please contact us to invite you again.</div>

        <div class="expire-logo">
            <img src="${client.logo}" alt="" class="client-logo primary-border-color"/>
        </div>
    </div>
    </body>
    </html>

</g:applyLayout>
