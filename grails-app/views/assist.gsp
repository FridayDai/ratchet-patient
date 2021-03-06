<g:set var="commonScriptPath" value="dist/commons.chunk.js"/>
<g:set var="scriptPath" value="dist/assist.bundle.js"/>
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

        .rc-btn.primary-button-color {
            color: ${  client.primaryColorHex?:'#0f137d'  };
            border-color: ${  client.primaryColorHex?:'#0f137d'  };
        }

        .rc-btn.primary-button-color:hover {
            color: #fff;
            background-color: ${  client.primaryColorHex?:'#0f137d'  };
        }

        .req-assist-btn[disabled], .req-assist-btn[disabled]:hover {
            color: ${client.primaryColorHex?:'#0f137d'} !important;
            background-color: #ffffff !important;
            cursor: default;
            opacity: 0.3;
        }
        </style>
    </head>

    <body>

    <div class="main">
        <h1 class="title container primary-color">Assist Me</h1>
        <div class="container">
            
            <form action="/addAssist" method="post" class="assist-form" id="assist-form">
                <div class="form-group">
                    <label class="lbl-group">TITLE<span class="primary-color">*</span></label>
                    <input id="assist-title" name="title" type="text" class="input-group title" required/>
                </div>

                <div class="form-group">
                    <label class="lbl-group">DESCRIPTION<span class="primary-color">*</span></label>
                    <textarea id="assist-desc" name="desc" type="text" class="input-group description" required></textarea>
                </div>

                <div class="form-group inline" style="display:none;">
                    <label class="lbl-group">NAME<span>*</span></label>
                    <label class="lbl-input" id="assist-name">${request.session.firstName} ${request.session.lastName}</label>
                </div>

                <div class="form-group">
                    <label class="lbl-req-field primary-color">*Required field</label>
                </div>

                <div class="form-group">
                    <button type="submit" class="rc-btn req-assist-btn primary-button-color" id="assist-me" data-patient-id="${patientId}" data-care-giver-id="${careGiverId}">Send</button>
                </div>
            </form>
            <div class="success-message hide">
                <p class="first-message">Thank you!</p>
                <p class="second-message">Message successfully sent.</p>
            </div>
        </div>
    </div>
    </body>
    </html>
</g:applyLayout>
