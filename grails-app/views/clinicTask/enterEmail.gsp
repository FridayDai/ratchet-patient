<g:set var="cssPath" value="clinicTask/enterEmail"/>
<g:set var="scriptPath" value="bundles/clinicEnterEmailBundle"/>
<g:applyLayout name="clientHeaderLayout">
    <html>
    <head>
        <title>Enter email</title>
        <style type="text/css">
        .primary-color {
            color: ${client.primaryColorHex?:'#0f137d'} !important;
        }

        .primary-border-color {
            border-color: ${client.primaryColorHex?:'#0f137d'} !important;
        }

        .primary-background-color {
            background-color: ${client.primaryColorHex?:'#0f137d'} !important;
        }

        .main-title {
            color: ${client.primaryColorHex?:'#0f137d'} !important;
        }

        .rc-btn {
            color: ${client.primaryColorHex?:'#0f137d'} !important;
            border-color: ${client.primaryColorHex?:'#0f137d'} !important;
        }

        .rc-btn:hover {
            color: #ffffff !important;
            background-color: ${client.primaryColorHex?:'#0f137d'} !important;
        }
        </style>

        <script language="javascript" type="text/javascript">
            window.history.forward();
        </script>
    </head>

    <body>
    <div class="container content">
        <div class="main-title">Enter email</div>
        <div class="sub-title">Please enter your email address to receive future task notifications via email.</div>

        <form id="email-enter-form" method="post">

            <div class="form-content">
                <div class="form-title">ENTER EMAIL</div>
                <input type="email" name="email" id="email" class="inline-email" placeholder="john.smith@email.com"/>
                <div class="error-container" id="error-container">
                    <g:if test="${errorMsg}">
                        <span id="error-msg" class="rc-error rc-error-label">${errorMsg}</span>
                    </g:if>
                </div>
            </div>

            <input type="hidden" name="clinicPathRoute" value="submitEmail">
            <input type="hidden" name="tasksList" value="${tasksList}">
            <input type="hidden" name="treatmentCode" value="${treatmentCode}">

            <input type="submit" id="enter-email-button" class="rc-btn enter-email-btn" value="Enter"/>
        </form>

        <input type="button" class="skip-button" id="skip-button" value="Skip"/>
    </div>

    %{--<div class="dialog-alert-cover" id="dialog-alert-cover"></div>--}%

    <div class="dialog-alert-container" id="dialog-alert-container">
        <div class="dialog-alert">
            <div class="dialog-inline">
                <div class="dialog-alert-header"></div>

                <div class="dialog-alert-content">
                    <div class="dialog-alert-title">Are you sure?</div>
                </div>

                <div class="dialog-alert-footer">
                    <div class="dialog-alert-buttonset">
                        <button id="jump-btn" class="red-btn">Yes</button>
                        <button id="close-btn">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </body>
    </html>
</g:applyLayout>

