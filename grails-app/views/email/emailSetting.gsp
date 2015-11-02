<g:set var="commonScriptPath" value="dist/commons.chunk.js"/>
<g:set var="scriptPath" value="dist/emailSetting.bundle.js"/>
<g:set var="cssPath" value="email/emailSetting"/>
<g:applyLayout name="clientContentLayout">
    <html>
    <head>
        <title>Email Setting</title>
        <style type="text/css">
        .rc-btn, .rc-primary-color, .rc-primary-color span {
            color: ${client.primaryColorHex?:'#0f137d'} !important;
            border-color: ${client.primaryColorHex?:'#0f137d'} !important;
        }

        .rc-btn:hover, .rc-primary-color:hover, .rc-primary-color:hover span {
            color: #ffffff !important;
            background-color: ${client.primaryColorHex?:'#0f137d'} !important;
        }
        </style>
    </head>

    <body>
    <div class="content container">
        <div class="desc">Enter the last 4 digit of your phone #:</div>

        <div id="email-setting-form">
            <form action="/mail_setting/${patientId}" method="post">
                <div class="form-control <g:if test="${errorMsg}">error</g:if>">
                    <input type="text" id="last4Number" name="last4Number" class="last-4-number" placeholder="Enter last 4 digits"
                           maxlength="4" required/>
                    <span class="rc-error-label"><g:if test="${errorMsg}">${errorMsg}</g:if></span>
                </div>
                <input type="submit" id="check-number-button" class="rc-btn check-number-btn" value="Edit E-mail Setting"/>
            </form>
        </div>
    </div>

    <div id="subscribe-dialog" class="hide" data-patient-id="${patientId}">
        <input type="checkbox" id="subscribe"/>
        <label for="subscribe">Remind me if I have a pending or overdue task.</label>
    </div>
    </body>
    </html>
</g:applyLayout>
