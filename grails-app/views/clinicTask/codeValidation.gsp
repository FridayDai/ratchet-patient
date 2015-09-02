<g:set var="cssPath" value="clinicTask/codeValidation"/>
<g:set var="scriptPath" value="codeValidationBundle"/>
<g:applyLayout name="main">
    <html>
    <head>
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

        .primary-hover-color:hover {
            color: #ffffff !important;
            background-color: ${client.primaryColorHex?:'#0f137d'} !important;
        }

        .task-go-btn {
            color: ${client.primaryColorHex?:'#0f137d'} !important;
            border-color: ${client.primaryColorHex?:'#0f137d'} !important;;
        }

        .task-go-btn:hover {
            color: #ffffff !important;
            background-color: ${client.primaryColorHex?:'#0f137d'} !important;
        }
        </style>

        <script language="javascript" type="text/javascript">
            window.history.forward();
        </script>
    </head>

    <body>
    <div class="main-container">
        <div class="content-layer">
            <div class="content-middle">
                <div class="welcome font-color">Welcome To</div>

                <div class="portal-name font-color">${client.portalName}</div>

                <div class="code-div">
                    <p class="enter-code-title">Enter Treatment Code</p>

                    <g:form class="code-validation-form" controller="clinicTestPath" action="checkClinicPath" method="post">
                        <div class="code-panel">
                            <input type="text" name="treatmentCode" class="treatment-code"
                                   placeholder="Enter 6 digits treatment code"
                                   maxlength="6"/>
                            <g:if test="${errorMsg}"><span class="rc-error-label">${errorMsg}</span></g:if>
                        </div>

                        <input type="hidden" name="clinicPathRoute" value="codeValidation">
                        <div class="task-go-panel">
                            <input type="submit" class="rc-btn primary-color task-go-btn" value="Go">
                        </div>
                    </g:form>
                </div>

                <span class="copy-right">
                    <span class="distance">Powered By</span>
                    <img class="logo" src="${assetPath(src: 'ratchet_logo_white.png')}"/>
                </span>
            </div>

        </div>

        <div class="inner-container top-layer">

        </div>

        <div class="inner-container middle-layer"></div>

        <div class="inner-container bottom-layer primary-background-color"></div>
    </div>


    <div class="mobile-alert-cover <g:if test="${errorMsg}">show</g:if>" id="mobile-alert-cover"></div>

    <div class="mobile-alert-container <g:if test="${errorMsg}">show</g:if>" id="mobile-alert-container">
        <div class="mobile-alert">
            <div class="mobile-alert-header">
                <div class="mobile-alert-title">Incorrect Treatment Code</div>

                <div class="mobile-alert-content">The treatment code you entered is incorrect. Please try again.</div>
            </div>

            <div class="mobile-alert-footer">
                <button>OK</button>
            </div>
        </div>
    </div>

    </body>
    </html>
</g:applyLayout>
