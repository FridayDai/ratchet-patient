<g:set var="cssPath" value="error/specifiedError"/>
<g:applyLayout name="error">
    <html>
    <head>
        <title>Email Confirm Error</title>
        <style type="text/css">
        .primary-color {
            color: ${client.primaryColorHex?:'#0f137d'} ;
        }
        </style>
    </head>

    <body>
    <div class="wrapper">
        <div class="expire-body">

            <div class="single-expire primary-color">Email already confirmed</div>
            %{--<div class="subhead primary-color">You have already confirmed your email address</div>--}%

            <div class="expire-logo">
                <img src="${client.logo}" alt="" class="client-logo"/>
            </div>
        </div>
    </div>

    </body>
    </html>

</g:applyLayout>

