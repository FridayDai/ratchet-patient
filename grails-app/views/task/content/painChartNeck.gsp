<g:set var="commonScriptPath" value="dist/commons.chunk.js"/>
<g:set var="scriptPath" value="dist/painChartTool.bundle.js"/>
<g:set var="cssPath" value="task/painChartNeck"/>
<g:if test="${!isInClinic}">
    <g:set var="hasAssistMe" value="true"/>
</g:if>

<g:applyLayout name="taskContent">
    <html>
    <head>
        <title>${Task?.title}</title>

        <style type="text/css">
        @media only screen and (max-width: 767px) {
            .task-time {
                color: ${     client.primaryColorHex?:'#0f137d'     } !important;
            }
        }

        .primary-color {
            color: ${     client.primaryColorHex?:'#0f137d'     } !important;
        }

        .primary-border-color {
            border-color: ${     client.primaryColorHex?:'#0f137d'     } !important;
        }

        .primary-background-color {
            background-color: ${     client.primaryColorHex?:'#0f137d'     } !important;
        }

        .task-done-btn {
            color: ${     client.primaryColorHex?:'#0f137d'     } !important;
            border-color: ${     client.primaryColorHex?:'#0f137d'     } !important;
        }

        .task-done-btn:hover {
            color: #ffffff !important;
            background-color: ${     client.primaryColorHex?:'#0f137d'     } !important;
        }

        .rc-choice-hidden:checked + .rc-radio:before, .rc-radio:hover:before {
            background-color: ${     client.primaryColorHex?:'#0f137d'     } !important;
        }

        .rc-choice-hidden:checked + .rc-checkbox {
            background-color: ${     client.primaryColorHex?:'#0f137d'     };
        }

        .modal+.ui-dialog-buttonpane button {
            border-color: ${     client.primaryColorHex?:'#0f137d'     };
            color: ${     client.primaryColorHex?:'#0f137d'     };
        }

        .modal+.ui-dialog-buttonpane button:hover,  .modal .ui-dialog-buttonpane button:focus {
            background-color: ${     client.primaryColorHex?:'#0f137d'     } !important;
        }

        .task-done-btn[disabled], .task-done-btn[disabled]:hover {
            color: ${client.primaryColorHex?:'#0f137d'} !important;
            background-color: #ffffff !important;
            cursor: default;
            opacity: 0.3;
        }
        </style>

        <g:if test="${isInClinic}">
            <script language="javascript" type="text/javascript">
                window.history.forward();
            </script>
        </g:if>
    </head>

    <body>
    <div class="pain-chart-neck task-content">
        <div class="task-list-wrapper container">

            <form action="" method="post" data-draft="${Draft}" data-no-pain-control="[0, 12]">
                <input type="hidden" name="code" value="${taskCode}"/>
                <input type="hidden" name="taskId" value="${Task.taskId}"/>
                <input type="hidden" name="taskType" value="${Task?.type}"/>

                <div id="pain-drawing-board" class="question-list-special pain-draw" data-chart="${'true'.toBoolean()}">
                    <div class="question">
                        <h3>Pain Drawing</h3>

                        <p>Click on the area where you feel pain and select the type of symptom(s) you feel in that area.</p>
                    </div>

                    <div class="answer-list chart-style">
                        <div id="draw-board" class="draw-board">
                            <span class="chart-content chart-left">
                                <div class="chart-title">Front</div>
                                <g:render template="/task/content/template/neckFront"></g:render>
                            </span>

                            <span class="chart-content">
                                <div class="chart-title">Back</div>
                                <g:render template="/task/content/template/neckBack"></g:render>
                            </span>

                            <div class="chart-direction">
                                <div>Symptoms:</div>

                                <div class="group-direction">
                                    <span class="icon-direction">N</span>
                                    <label>Numbness</label>
                                </div>

                                <div class="group-direction">
                                    <span class="icon-direction">A</span>
                                    <label>Ache</label>
                                </div>

                                <div class="group-direction">
                                    <span class="icon-direction">S</span>
                                    <label>Stabbing</label>
                                </div>

                                <div class="group-direction">
                                    <span class="icon-direction">B</span>
                                    <label>Burning</label>
                                </div>

                                <div class="group-direction">
                                    <span class="icon-direction">C</span>
                                    <label>Cramping</label>
                                </div>

                                <div class="group-direction">
                                    <span class="icon-direction">P</span>
                                    <label>Pins & Needles</label>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div id="svg-choice-result">
                        <input type="hidden" id="Front-Right-Shoulder-hidden" name="choices.0"
                               value="${Draft?.'0' ?: ''}"/>
                        <input type="hidden" id="Front-Left-Shoulder-hidden" name="choices.1"
                               value="${Draft?.'1' ?: ''}"/>
                        <input type="hidden" id="Front-Right-Arm-hidden" name="choices.2" value="${Draft?.'2' ?: ''}"/>
                        <input type="hidden" id="Front-Left-Arm-hidden" name="choices.3" value="${Draft?.'3' ?: ''}"/>

                        <input type="hidden" id="Back-Left-Arm-hidden" name="choices.4" value="${Draft?.'4' ?: ''}"/>
                        <input type="hidden" id="Back-Right-Arm-hidden" name="choices.5" value="${Draft?.'5' ?: ''}"/>
                        <input type="hidden" id="Neck-hidden" name="choices.6" value="${Draft?.'6' ?: ''}"/>
                        <input type="hidden" id="Back-Left-Shoulder-hidden" name="choices.7"
                               value="${Draft?.'7' ?: ''}"/>
                        <input type="hidden" id="Back-Right-Shoulder-hidden" name="choices.8"
                               value="${Draft?.'8' ?: ''}"/>
                    </div>
                </div>

                <div id="pain-percent-question" class="question-list-special" data-select="${true}"
                     data-percentage-keys="[9, 10, 11]">
                    <div class="question">
                        <div>What percent of your pain is NECK pain vs. SHOULDER pain vs. ARM pain?</div>

                        <div><i>The amount from each area should add up to 100%</i></div>
                    </div>

                    <div class="answer-list odi-style">
                        <div class="select-contain">
                            <span class="select-group">
                                <select class="select-menu" name="choices.9" data-title="NECK PAIN"
                                        data-mobile-dialog-event="showMobileSelectMenuDialog">
                                    <g:each var="j" in="${(0..<10)}">
                                        <option value="${j * 10}"
                                                <g:if test="${Draft?.'9' == (j * 10).toString()}">selected</g:if>>${j * 10}</option>
                                    </g:each>
                                </select>
                                <span class="select-percent">% Neck <span>+</span></span>

                            </span>

                            <span class="select-group">
                                <select class="select-menu" name="choices.10" data-title="SHOULDER PAIN"
                                        data-mobile-dialog-event="showMobileSelectMenuDialog">
                                    <g:each var="j" in="${(0..<10)}">
                                        <option value="${j * 10}"
                                                <g:if test="${Draft?.'10' == (j * 10).toString()}">selected</g:if>>${j * 10}</option>
                                    </g:each>
                                </select>
                                <span class="select-percent">% Shoulder <span>+</span></span>
                            </span>

                            <span class="select-group">
                                <select class="select-menu" name="choices.11" data-title="ARM PAIN"
                                        data-mobile-dialog-event="showMobileSelectMenuDialog">
                                    <g:each var="j" in="${(0..<10)}">
                                        <option value="${j * 10}"
                                                <g:if test="${Draft?.'11' == (j * 10).toString()}">selected</g:if>>${j * 10}</option>
                                    </g:each>
                                </select>
                                <span class="select-percent">% Arm</span>
                                <span class="select-percent-result">
                                    = <span id="select-percent-number" class="select-percent-number">
                                    <span id="select-percent-score">-</span> /100</span>
                                </span>
                            </span>
                        </div>
                        <li class="answer">
                            <span id="no-pain-choice" class="inline">
                                <div class="text">I have no neck, shoulder or arm pain</div>
                                <label class="choice">
                                    <input id="no-pain-toggle" type="checkbox" name="choices.12" value="on"
                                           class="rc-choice-hidden"/>
                                    <span class="rc-checkbox primary-radio-color pain-toggle"></span>
                                </label>
                            </span>
                        </li>
                    </div>
                </div>

                <div class="section-summary">
                    <p>
                        On a scale of 0 to 10, mark the average level of discomfort in the last week, with 0 being none and 10 being the worst pain you can imagine.
                    </p>
                </div>

                <g:each var="i" in="${(0..<3)}">
                    <g:if test="${i == 0}">
                        <g:set var="question" value="['neck pain', 'back of the neck']"/>
                    </g:if>
                    <g:elseif test="${i == 1}">
                        <g:set var="question" value="['shoulder pain', 'including the shoulder blades']"/>
                    </g:elseif>
                    <g:else>
                        <g:set var="question" value="['arm pain', 'including the hands']"/>
                    </g:else>

                    <div class="section-list">
                        <div class="section-title">
                            <strong class="capitalize">${question[0]}</strong> - <i>${question[1]}</i>
                        </div>

                        <div class="question-list">
                            <div class="question primary-color">
                                Average level of <strong>${question[0]}.</strong>
                            </div>

                            <div class="answer-list nrs">
                                <div class="answer-description">
                                    <span class="no-pain">No Pain</span>
                                    <span class="severe-pain">Severe Pain</span>
                                </div>
                                <ul class="list">
                                    <g:each var="j" in="${(0..<11)}">
                                        <li class="answer">
                                            <div class="text">
                                                ${j} -
                                                <g:if test="${j == 0}">No Pain</g:if>
                                                <g:if test="${j >= 1 && j < 4}">Mid Pain</g:if>
                                                <g:if test="${j >= 4 && j < 7}">Moderate Pain</g:if>
                                                <g:if test="${j >= 7 && j < 11}">Severe Pain</g:if>
                                            </div>
                                            <label class="choice choice-number choice-number-${j}">
                                                <input type="radio" class="rc-choice-hidden"
                                                       name="choices.${13 + 2 * i}"
                                                    <g:if test="${Draft && Draft[(13 + 2 * i).toString()] == j.toString()}">checked</g:if>
                                                       value="${j}"/>
                                                <span class="rc-radio"></span>
                                            </label>
                                        </li>
                                    </g:each>
                                </ul>
                            </div>
                        </div>

                        <div class="question-list">
                            <div class="question primary-color">
                                Frequency of <strong>${question[0]}.</strong>
                            </div>

                            <div class="answer-list koos-style">
                                <ul class="list horizontal-list">
                                    <g:set var="choice"
                                           value="['Never', 'Monthly', 'Weekly', 'Daily', 'Hourly', 'Constant']"/>
                                    <g:each var="j" in="${0..<6}">
                                        <li class="answer">
                                            <div class="text">${choice[j]}</div>
                                            <label class="choice">
                                                <input type="radio" class="rc-choice-hidden"
                                                       name="choices.${13 + 2 * i + 1}"
                                                    <g:if test="${Draft && Draft[(13 + 2 * i + 1).toString()] == j.toString()}">checked</g:if>
                                                       value="${j}"/>
                                                <span class="rc-radio"></span>
                                            </label>
                                        </li>
                                    </g:each>
                                </ul>
                            </div>
                        </div>
                    </div>

                </g:each>


                <g:if test="${itemIndex != null && (itemIndex + 1) < tasksLength}">
                    <input type="hidden" name="itemIndex" value="${itemIndex + 1}">
                </g:if>
                <g:else>
                    <input type="hidden" name="itemIndex" value="${tasksLength}">
                </g:else>

                <input type="hidden" name="tasksList" value="${tasksList}">
                <input type="hidden" name="treatmentCode" value="${treatmentCode}">
                <input type="hidden" name="isInClinic" value="${isInClinic}">
                <input type="hidden" name="pathRoute" value="todoTask">
                <input type="hidden" name="emailStatus" value="${emailStatus}">
                <input type="hidden" name="hardcodeTask" value="true">

                <div class="task-done-panel">
                    <input type="submit" name="submit" class="rc-btn task-done-btn" value="I'm Done">
                </div>
            </form>

            <div id="symptom-choice-dialog" class="modal ui-hidden desktop-mobile-dialog">
                <div class="msg-header">Select one or more of the symptoms for your <strong id="part-name">Part</strong>
                </div>

                <div class="msg-center code">
                    <div class="msg-center code">
                        <g:set var="symptomsArr"
                               value="['Numbness', 'Stabbing', 'Cramping', 'Ache', 'Burning', 'Pins & Needles']"/>
                        <g:set var="symptomsVal" value="['N', 'S', 'C', 'A', 'B', 'P']"/>

                        <div class="answer-list" autofocus>
                            <ul class="list">
                                <g:each var="symptom" in="${symptomsArr}" status="index">
                                    <li class="answer">
                                        <div class="text">${symptom}</div>
                                        <label class="choice">
                                            <input type="checkbox"
                                                   data-index="${index}"
                                                   class="rc-choice-hidden"
                                                   name="mobileEnterYear"
                                                   value="${symptomsVal[index]}"/>
                                            <span class="rc-checkbox primary-radio-color"></span>
                                        </label>
                                    </li>
                                </g:each>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <div id="number-mobile-dialog" data-title="NECK PAIN" class="modal ui-hidden">
                <div class="msg-header">Please select a number</div>

                <div class="msg-center code">
                    <div class="answer-list" autofocus>
                        <ul class="list">
                            <g:each var="j" in="${0..<10}">
                                <li class="answer">
                                    <div class="text">${j * 10}</div>
                                    <label class="choice">
                                        <input type="radio"
                                               data-index="${j}"
                                               class="rc-choice-hidden"
                                               name="number"
                                               value="${j * 10}"/>
                                        <span class="rc-radio primary-radio-color"></span>
                                    </label>
                                </li>
                            </g:each>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <div class="footer" id="footer">
        <p><span class="copy-right">© 2016 <img class="logo" src="${assetPath(src: 'Ratchet_Logo_grey.png')}"/></span><span class="vertical-line">|</span>Version RH0.1<span class="vertical-line">|</span>All Rights Reserved.</p>
        <p>Terms of Service<span class="vertical-line">|</span>Privacy Policy</p>
    </div>

    <g:render template="/shared/pageMask"></g:render>
    </body>
    </html>
    <content tag="GA">
        <script>
            ga('send', 'event', '${taskTitle}', 'in progress', '${taskCode}');
        </script>
    </content>
</g:applyLayout>








