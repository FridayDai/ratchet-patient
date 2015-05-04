<g:set var="scriptPath" value="assistBundle"/>
<g:set var="cssPath" value="assist/assist"/>
<g:applyLayout name="clientHeaderLayout">
    <head>
        <title>ASSIST</title>
        <style type="text/css">
        .primary-color {
            color: ${  client.primaryColorHex?:'#0f137d'  } !important;
        }

        .primary-border-color {
            border-color: ${  client.primaryColorHex?:'#0f137d'  } !important;
        }

        .primary-background-color {
            background-color: ${  client.primaryColorHex?:'#0f137d'  } !important;
        }

        .circle-list li:before {
            color: ${  client.primaryColorHex?:'#0f137d'  } !important;
        }
        </style>
    </head>

    <body>

    <div class="main">
        <h1 class="title container primary-color">Assist Me</h1>
        <div class="container">
            
            <g:form class="assist-form ui-hidden" id="assist-form" name="assist-form">

                <div class="form-group">
                    <label class="lbl-group">TITLE<span class="primary-color">*</span></label>
                    <input id="assist-title" name="title" type="text" class="input-group title" required/>
                </div>

                <div class="form-group">
                    <label class="lbl-group">DESCRIPTION<span class="primary-color">*</span></label>
                    <textarea id="assist-desc" name="description" type="text" class="input-group description" required></textarea>
                </div>

                <div class="form-group inline" style="display:none;">
                    <label class="lbl-group">NAME<span>*</span></label>
                    <label class="lbl-input" id="assist-name">${request.session.firstName} ${request.session.lastName}</label>
                </div>

                <div class="form-group">
                    <label class="lbl-req-field primary-color">*Required field</label>
                </div>

                <div class="form-group">
                    <button type="submit" class="rc-btn req-assist-btn" id="assist-me" data-patientid="${patientId}">Send</button>
                </div>

            </g:form>
            <div class="success-message" style="display:none;">
                <div class="first-message">Thank you!</div>
                <div class="second-message">Message successfully sent.</div>
            </div>
        </div>
    </div>
    </body>
    </html>
</g:applyLayout>
