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

            <form action="" method="post" data-draft="${Draft}" data-no-pain-control="[0, 9]">
                <input type="hidden" name="code" value="${taskCode}"/>
                <input type="hidden" name="taskId" value="${Task.taskId}"/>
                <input type="hidden" name="taskType" value="${Task?.type}"/>

                <div id="pain-drawing-board" class="question-list-special pain-draw" data-optional="${'true'.toBoolean()}">
                    <div class="question">
                        <h3>Pain Drawing</h3>

                        <p>Click on the area where you feel pain and select the type of symptom(s) you feel in that area.</p>
                    </div>

                    <div class="answer-list chart-style">
                        <div id="draw-board" class="draw-board">
                            <span class="chart-content chart-left">
                                <div class="chart-title">Front</div>
                                <g:render template="/task/content/template/backFront"></g:render>
                            </span>

                            <span class="chart-content">
                                <div class="chart-title">Back</div>
                                <g:render template="/task/content/template/backBack"></g:render>
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
                        <input type="hidden" id="Front-Right-Leg-hidden" name="choices.0" value="${Draft?.'0'?:''}"/>
                        <input type="hidden" id="Front-Left-Leg-hidden" name="choices.1" value="${Draft?.'1'?:''}"/>

                        <input type="hidden" id="Back-hidden" name="choices.2" value="${Draft?.'2'?:''}"/>
                        <input type="hidden" id="Buttock-hidden" name="choices.3" value="${Draft?.'3'?:''}"/>
                        <input type="hidden" id="Back-Right-Leg-hidden" name="choices.4" value="${Draft?.'4'?:''}"/>
                        <input type="hidden" id="Back-Left-Leg-hidden" name="choices.5" value="${Draft?.'5'?:''}"/>
                    </div>
                </div>

                <div id="pain-percent-question" class="question-list-special">
                    <div class="question">
                        <div>What percent of your pain is BACK pain vs. BUTTOCK pain vs. LEG pain?</div>

                        <div><i>The amount from each area should add up to 100%</i></div>
                    </div>

                    <div class="answer-list odi-style">
                        <div class="select-contain">
                            <span class="select-group">
                                <select class="select-menu" name="choices.6">
                                    <option value="0">0</option>
                                    <g:each var="j" in="${(1..<10)}">
                                        <option value="${j * 10}" <g:if test="${Draft?.'6' == (j * 10).toString()}">selected</g:if>>${j * 10}</option>
                                    </g:each>
                                </select>
                                <span class="select-percent">% Back <span>+</span></span>

                            </span>

                            <span class="select-group">
                                <select class="select-menu" name="choices.7">
                                    <option value="0">0</option>
                                    <g:each var="j" in="${(1..<10)}">
                                        <option value="${j * 10}" <g:if test="${Draft?.'7' == (j * 10).toString()}">selected</g:if>>${j * 10}</option>
                                    </g:each>
                                </select>
                                <span class="select-percent">% Buttock <span>+</span></span>
                            </span>

                            <span class="select-group">
                                <select class="select-menu" name="choices.8">
                                    <option value="0">0</option>
                                    <g:each var="j" in="${(1..<10)}">
                                        <option value="${j * 10}" <g:if test="${Draft?.'8' == (j * 10).toString()}">selected</g:if>>${j * 10}</option>
                                    </g:each>
                                </select>
                                <span class="select-percent">% Leg </span>
                                <span class="select-percent-result">
                                    = <span id="select-percent-number" class="select-percent-number">
                                    <span id="select-percent-score">-</span> /100</span>
                                </span>
                            </span>
                        </div>
                        <li class="answer">
                            <div class="text">
                                I have no back, buttock or leg pain</div>
                            <label class="choice">
                                <input id="no-pain-toggle" type="checkbox" name="choices.9" value="on"
                                       class="rc-choice-hidden"/>
                                <span class="rc-checkbox primary-radio-color pain-toggle"></span>
                            </label>
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
                        <g:set var="question" value="['back pain', 'above the buttocks']"/>
                    </g:if>
                    <g:elseif test="${i == 1}">
                        <g:set var="question" value="['buttock pain', 'in the gluteal folds (butt cheeks)']"/>
                    </g:elseif>
                    <g:else>
                        <g:set var="question" value="['leg pain', 'front / back of legs (below the buttocks)']"/>
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
                                                       name="choices.${10 + 2 * i}"
                                                    <g:if test="${Draft && Draft[(10 + 2 * i).toString()] == j.toString()}"> checked</g:if>
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
                                                       name="choices.${10 + 2 * i + 1}"
                                                    <g:if test="${Draft && Draft[(10 + 2 * i + 1).toString()] == j.toString()}"> checked</g:if>
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


                <g:if test="${(itemIndex + 1) < tasksLength}">
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
                    <input type="submit" class="rc-btn task-done-btn" value="I'm Done">
                </div>
            </form>

            <div id="symptom-choice-dialog" class="modal ui-hidden">
                <div class="msg-header">Select one or more of the symptoms for your <strong id="part-name">Part</strong></div>

                <div class="msg-center code">
                    <div class="one-choice">
                        <label>
                            <input type="checkbox" value="N">
                            Numbness
                        </label>
                    </div>

                    <div class="one-choice">
                        <label>
                            <input type="checkbox" value="S">
                            Stabbing
                        </label>
                    </div>

                    <div class="one-choice">
                        <label>
                            <input type="checkbox" value="C">
                            Cramping
                        </label>
                    </div>

                    <div class="one-choice">
                        <label>
                            <input type="checkbox" value="A">
                            Ache
                        </label>
                    </div>

                    <div class="one-choice">
                        <label>
                            <input type="checkbox" value="B">
                            Burning
                        </label>
                    </div>

                    <div class="one-choice">
                        <label>
                            <input type="checkbox" value="P">
                            Pins & Needles
                        </label>
                    </div>
                </div>
            </div>

            <div id="number-mobile-dialog" data-title="BACK PAIN" class="modal ui-hidden">
                <div class="msg-header">Please select a number</div>

                <div class="msg-center code">
                    <g:each var="j" in="${0..<10}">
                        <div class="one-choice">
                            <label>
                                <input type="radio" name="number" value="${j * 10}">
                                ${j * 10}
                            </label>
                        </div>
                    </g:each>
                </div>
            </div>

        </div>
    </div>

    </body>
    </html>
    <content tag="GA">
        <script>
            ga('send', 'event', '${taskTitle}', 'in progress', '${taskCode}');
        </script>
    </content>
</g:applyLayout>








