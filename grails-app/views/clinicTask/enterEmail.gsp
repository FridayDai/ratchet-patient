<g:set var="cssPath" value="clinicTask/enterEmail"/>
<g:set var="scriptPath" value="clinicEnterEmailBundle"/>
<g:applyLayout name="clientContentLayout">
    <html>
    <head>
        <title>Enter email</title>
        <style type="text/css">
        .rc-btn {
            color: ${client.primaryColorHex?:'#0f137d'} !important;
            border-color: ${client.primaryColorHex?:'#0f137d'} !important;
        }

        .rc-btn:hover {
            color: #ffffff !important;
            background-color: ${client.primaryColorHex?:'#0f137d'} !important;
        }
        </style>
    </head>

    <body>
    <div class="content container">
        <div class="main-title">Enter email</div>
        <div class="desc">Please enter your email address to receive future task notifications via email.</div>

        <form id="email-enter-form">

            <div class="form-control">
                <div class="form-title">ENTER EMAIL</div>
                <input type="email" name="email" class="inline-email" placeholder="john.smith@email.com"/>
                <span class="rc-error rc-error-label">Invalid email.</span>
            </div>

            <input type="hidden" name="clinicPathRoute" value="submitEmail">
            <input type="hidden" name="tasksList" value="${tasksList}">
            <input type="hidden" name="treatmentCode" value="${treatmentCode}">
            <input type="hidden" name="patientId" value="${patientId}">

            <input type="submit" id="enter-email-button" class="rc-btn enter-email-btn" value="Enter"/>
        </form>

        <input type="button" id="skip-button" value="Skip"/>
    </div>

    %{--<div class="dialog-alert-cover" id="dialog-alert-cover"></div>--}%

    <div class="dialog-alert-container hide" id="dialog-alert-container">
        <div class="dialog-alert">
            <div class="dialog-alert-header">

            </div>

            <div class="dialog-alert-content">
                <div class="dialog-alert-title">Are you sure?</div>
            </div>

            <div class="dialog-alert-footer">
                <div class="dialog-alert-buttonset">
                    <button>Yes</button>
                    <button>Cancel</button>
                </div>
            </div>
        </div>
    </div>
    </body>
    </html>
</g:applyLayout>

