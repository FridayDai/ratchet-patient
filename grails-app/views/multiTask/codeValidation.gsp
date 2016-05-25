<g:set var="cssPath" value="clinicTask/codeValidation"/>
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

                <div class="portal-name font-color">Grace County Patient Portal</div>

                <div class="code-div">
                    <p class="enter-code-title">Enter Treatment Code</p>
                    <g:if test="${errorMsg}">
                        <div class="rc-server-error rc-error-label">${errorMsg}</div>
                    </g:if>
                    <form action="/in-clinic" method="post" class="code-validation-form">
                        <div class="code-panel">
                            <input type="text" name="treatmentCode" class="treatment-code"
                                   placeholder="Enter 6 digits treatment code"
                                   maxlength="6"/>
                        </div>

                        <input type="hidden" name="pathRoute" value="codeValidation">
                        <input type="hidden" name="isInClinic" value="true">
                        <div class="task-go-panel">
                            <input type="submit" class="rc-btn primary-color task-go-btn" value="Go">
                        </div>
                    </form>
                </div>

                <span class="copy-right">
                    <span class="distance">Powered By</span>
                    <img class="logo" src="${assetPath(src: 'ratchet_logo_white.png')}"/>
                </span>
            </div>

        </div>

        <div class="inner-container top-layer"></div>
        <div class="inner-container middle-layer"></div>
        <div class="inner-container bottom-layer primary-background-color"></div>
    </div>
    </body>
    </html>
</g:applyLayout>
