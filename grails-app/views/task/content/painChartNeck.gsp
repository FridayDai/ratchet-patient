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
                color: ${   client.primaryColorHex?:'#0f137d'   } !important;
            }
        }

        .primary-color {
            color: ${   client.primaryColorHex?:'#0f137d'   } !important;
        }

        .primary-border-color {
            border-color: ${   client.primaryColorHex?:'#0f137d'   } !important;
        }

        .primary-background-color {
            background-color: ${   client.primaryColorHex?:'#0f137d'   } !important;
        }

        .task-done-btn {
            color: ${   client.primaryColorHex?:'#0f137d'   } !important;
            border-color: ${   client.primaryColorHex?:'#0f137d'   } !important;;
        }

        .task-done-btn:hover {
            color: #ffffff !important;
            background-color: ${   client.primaryColorHex?:'#0f137d'   } !important;
        }

        .rc-choice-hidden:checked + .rc-radio:before, .rc-radio:hover:before {
            background-color: ${   client.primaryColorHex?:'#0f137d'   } !important;
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

            <div class="question-list pain-draw">
                <div class="question">
                    <h3>Pain Drawing</h3>

                    <p>Click on the area where you feel pain and select the type of symptom(s) you feel in that area</p>
                </div>

                <div class="answer-list chart-style">
                    <div id="draw-board" class="draw-board">
                        <span class="chart-content chart-left">
                            <div class="chart-title">Font</div>
                            <g:render template="/task/content/template/neckFont"></g:render>
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
            </div>

            <form action="" method="post">
                <input type="hidden" name="code" value="${taskCode}"/>
                <input type="hidden" name="taskType" value="${Task?.type}"/>

                <div id="svg-choice-result">
                    <input type="hidden" name="choice.0" value=""/>
                    <input type="hidden" name="choice.1" value=""/>
                    <input type="hidden" name="choice.2" value=""/>
                    <input type="hidden" name="choice.3" value=""/>
                    <input type="hidden" name="choice.4" value=""/>
                    <input type="hidden" name="choice.5" value=""/>
                    <input type="hidden" name="choice.6" value=""/>
                    <input type="hidden" name="choice.7" value=""/>
                    <input type="hidden" name="choice.8" value=""/>
                </div>

                <div id="pain-percent-question" class="question-list">
                    <div class="question">
                        <p>What percent of your pain is NECK pain vs. SHOULDER pain vs. ARM pain?</p>

                        <p><i>The amount from each area should add up to 100%</i></p>
                    </div>

                    <div class="answer-list odi-style">
                        <div class="select-contain">
                            <span>
                                <select class="select-menu" name="choice.9">
                                    <option value="0">0</option>
                                    <option value="10">10</option>
                                    <option value="20">20</option>
                                    <option value="30">30</option>
                                    <option value="40">40</option>
                                    <option value="50">50</option>
                                    <option value="60">60</option>
                                    <option value="70">70</option>
                                    <option value="80">80</option>
                                    <option value="90">90</option>
                                </select>
                                <span class="select-percent">%Neck<span>+</span></span>

                            </span>

                            <select class="select-menu" name="choice.10">
                                <option value="0">0</option>
                                <option value="10">10</option>
                                <option value="20">20</option>
                                <option value="30">30</option>
                                <option value="40">40</option>
                                <option value="50">50</option>
                                <option value="60">60</option>
                                <option value="70">70</option>
                                <option value="80">80</option>
                                <option value="90">90</option>
                            </select>
                            <span class="select-percent">%Shoulder<span>+</span></span>

                            <select class="select-menu" name="choice.11">
                                <option value="0">0</option>
                                <option value="10">10</option>
                                <option value="20">20</option>
                                <option value="30">30</option>
                                <option value="40">40</option>
                                <option value="50">50</option>
                                <option value="60">60</option>
                                <option value="70">70</option>
                                <option value="80">80</option>
                                <option value="90">90</option>
                            </select>
                            <span class="select-percent"> %Arm <span>= 100%</span></span>

                        </div>
                        <li class="answer">
                            <div class="text">I have no neck, shoulder or arm pain</div>
                            <label class="choice">
                                <input id="no-pain-toggle" type="checkbox" name="choice.12"
                                       class="rc-choice-hidden"/>
                                <span class="rc-radio primary-radio-color"></span>
                            </label>
                        </li>
                    </div>
                </div>

                <div class="section-title">
                    <p>
                        On a scale of 0 to 10, mark the average level of discomfort in the last week, with 0 being none and 10 being the worst pain you can imagine.
                    </p>
                </div>

                <g:each var="i" in="${(0..<3)}">
                    <div class="question-list">
                        <g:if test="${i == 0}">
                            <g:set var="question" value="['neck pain', 'back of the neck']"/>
                        </g:if>
                        <g:if test="${i == 1}">
                            <g:set var="question" value="['shoulder pain', 'including the shoulder blades']"/>
                        </g:if>
                        <g:else>
                            <g:set var="question" value="['arm pain', 'including the hands']"/>
                        </g:else>

                        <div class="question">
                            <strong class="capitalize">${question[0]}</strong> - ${question[1]}
                        </div>

                        <div class="answer-list nrs">
                            <div class="answer-title primary-color">Average level of <strong>${question[0]}.</strong></div>

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
                                            <input type="radio" class="rc-choice-hidden"/>
                                            <span class="rc-radio"></span>
                                        </label>
                                    </li>
                                </g:each>
                            </ul>
                        </div>

                        <div class="answer-list koos-style">
                            <div class="answer-title primary-color">Frequency of <strong>${question[0]}.</strong></div>
                            <ul class="list horizontal-list">
                                <g:set var="choice"
                                       value="['Never', 'Monthly', 'Weekly', 'Daily', 'Hourly', 'Constant']"/>
                                <g:each var="j" in="${0..<5}">
                                    <li class="answer">
                                        <div class="text">${choice[j]}</div>
                                        <label class="choice">
                                            <input type="radio" class="rc-choice-hidden"/>
                                            <span class="rc-radio"></span>
                                        </label>
                                    </li>
                                </g:each>
                            </ul>
                        </div>
                    </div>

                </g:each>


                <g:if test="${isInClinic}">
                    <g:if test="${(itemIndex + 1) < tasksLength}">
                        <input type="hidden" name="itemIndex" value="${itemIndex + 1}">
                    </g:if>
                    <g:else>
                        <input type="hidden" name="itemIndex" value="${tasksLength}">
                    </g:else>

                    <input type="hidden" name="tasksList" value="${tasksList}">
                    <input type="hidden" name="treatmentCode" value="${treatmentCode}">
                    <input type="hidden" name="clinicPathRoute" value="todoTask">
                    <input type="hidden" name="patientId" value="${patientId}">
                    <input type="hidden" name="emailStatus" value="${emailStatus}">
                </g:if>

                <div class="task-done-panel">
                    <input type="submit" class="rc-btn task-done-btn" value="I'm Done">
                </div>
            </form>

            <div id="symptom-choice-dialog" class="warn ui-hidden">
                <div class="msg-header">Select one or more of the symptoms for your <strong>Back Left Arm</strong></div>

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








