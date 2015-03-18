<g:set var="cssPath" value="email/emailSetting"/>
<g:set var="scriptPath" value="emailSettingBundle"/>
<g:applyLayout name="clientContentLayout">
    <html>
    <head>
        <title>Email Setting</title>
        <style type="text/css">
        .rc-btn {
            color: ${             client.primaryColorHex?:'#0f137d'             } !important;
            border-color: ${             client.primaryColorHex?:'#0f137d'             } !important;
        }

        .rc-btn:hover {
            color: #ffffff !important;
            background-color: ${             client.primaryColorHex?:'#0f137d'             } !important;
        }
        </style>
    </head>

    <body>
    <div class="content container">
        <div class="desc">Enter the last 4 digit of your phone #:</div>

        <div id="email-setting-form">
            <div class="form-control<g:if test="${errorMsg}">error</g:if>">
                <input type="text" name="last4Number" class="last-4-number" placeholder="Enter last 4 digits"
                       maxlength="4"/>
                <g:if test="${errorMsg}"><span class="rc-error-label">${errorMsg}</span></g:if>
            </div>
            <input type="button" id="check-number-button" class="rc-btn check-number-btn"
                   data-patient-id="${patientId}" value="Edit E-mail Setting"/>
        </div>
    </div>

    <div class="interact-model-container displaynone" id="interact-model-container">
        <div class="interact-modal-header">
            <div class="title">EDIT EMAIL SETTING</div>
            <span class="close-btn" id="close-btn">X</span>
        </div>

        <div class="interact-modal-body">
            <div class="interact-modal-content">
                <input type="checkbox" checked id="subscribe"/>
                <span>Remind me if I have pending or overdue task.</span>
            </div>

            <input type="button" class="btn rc-btn btn-update" id="btn-update" data-patient-id="${patientId}"
                   value="Update Setting"/>
        </div>
    </div>

    <div class="mobile-alert-cover<g:if test="${errorMsg}">show</g:if>" id="mobile-alert-cover"></div>

    <div class="mobile-alert-container<g:if test="${errorMsg}">show</g:if>" id="mobile-alert-container">
        <div class="mobile-alert">
            <div class="mobile-alert-header">
                <div class="mobile-alert-title">Incorrect Number</div>

                <div class="mobile-alert-content">The number you entered is incorrect. Please try again.</div>
            </div>

            <div class="mobile-alert-footer">
                <button>OK</button>
            </div>
        </div>
    </div>
    </body>
    </html>
</g:applyLayout>
