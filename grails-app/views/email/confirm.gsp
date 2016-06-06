<g:set var="commonScriptPath" value="dist/commons.chunk.js"/>
<g:set var="scriptPath" value="dist/emailConfirm.bundle.js"/>
<g:set var="cssPath" value="email/confirm"/>
<g:applyLayout name="clientHeaderLayout">
    <html>
    <head>
        <title>Email Confirmation</title>

        <style type="text/css">

        .primary-color {
            color: ${ client.primaryColorHex?:'#0f137d' } !important;
        }

        .btn-submit {
            color: ${ client.primaryColorHex?:'#0f137d' } !important;
            border-color: ${ client.primaryColorHex?:'#0f137d' } !important;;
        }

        .btn-submit:hover, .btn-submit:focus {
            color: #ffffff !important;
            background-color: ${ client.primaryColorHex?:'#0f137d' } !important;
        }

        .rc-choice-hidden:checked + .rc-checkbox {
            background-color: ${ client.primaryColorHex?:'#0f137d' } !important;
        }
        </style>
    </head>

    <body>
    <div class="main container">
        <g:if test="${patientConfirm && hasBirthday}">
            <p class="title">One more step to confirm your email...</p>
        </g:if>
        <g:if test="${careGiverConfirm}">
            <p class="title">One more step to confirm as a caregiver...</p>
        </g:if>

        <form action="" method="post" class="confirm-form">
            <div class="content" id="form-content">

                <g:if test="${(patientConfirm && hasBirthday) || careGiverConfirm}">
                    <div class="content-birth">
                        <g:if test="${patientConfirm}">
                            <div class="label-birth">
                                Please enter your <strong>year</strong> of birth.
                            </div>
                        </g:if>
                        <g:if test="${careGiverConfirm}">
                            <div class="label-birth">
                                Please enter patient's <strong>year</strong> of birth.
                            </div>
                        </g:if>

                        <span class="input-group">
                            <input id="birthday" type="text" name="birthday" class="form-control input-birth" maxlength="4" placeholder="YYYY"/>
                            <g:if test="${errorMsg}">
                                <div class="error-container gsp-error">
                                    <div class="rc-error-label">${errorMsg}</div>
                                </div>
                            </g:if>
                        </span>
                    </div>
                </g:if>

                <div class="agree-group">
                    <label class="choice">
                        <input id="agree-toggle" type="checkbox" name="agree" value="true"
                               class="rc-choice-hidden"/>
                        <span class="rc-checkbox  agree-toggle"></span>
                    </label>

                    <div class="input-context">
                        I agree to the system’s
                        <a class="primary-color link" href="http://www.ratchethealth.com/terms-of-service/"
                           target="_blank">Terms of Service</a>
                        and the
                        <a class="primary-color link" href="http://www.ratchethealth.com/privacy-policy/"
                           target="_blank">Privacy Policy</a>
                    </div>

                    <div class="error-tip">
                        In order to use our services, you must agree to the Terms of Service and the Privacy Policy. Without it, we won’t be able to communicate important treatment information with you via email.
                    </div>
                </div>

            </div>

            <div class="form-footer">
                <button type="submit" class="btn btn-submit" id='confirm-email'>Confirm Email</button>
            </div>
        </form>
    </div>

    </body>
    </html>
</g:applyLayout>
