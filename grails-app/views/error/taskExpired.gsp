<g:set var="cssPath" value="error/expired"/>
<g:applyLayout name="error">
    <html>
    <head>
        <title>Task Expired</title>
        <style type="text/css">
        .primary-color {
            color: ${client.primaryColorHex?:'#0f137d'} ;
        }
        </style>
    </head>

    <body>
    <div class="expire-body">

        <div class="single-expire primary-color">This task has expired</div>

        <div class="expire-logo">
            <img src="${client.logo}" alt="" class="client-logo"/>
        </div>
    </div>
    </body>
    </html>

</g:applyLayout>
