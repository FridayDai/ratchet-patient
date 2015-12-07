<g:set var="commonScriptPath" value="dist/commons.chunk.js"/>
<g:set var="scriptPath" value="dist/newPatientQuestionnaireTool.bundle.js"/>
<g:set var="cssPath" value="task/newPatientQuestionnaire"/>
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
            width: 21px!important;
            height: 21px!important;
        }

        .rc-choice-hidden:checked + .rc-checkbox {
            background-color: ${     client.primaryColorHex?:'#0f137d'     };
        }
        </style>

        <g:if test="${isInClinic}">
            <script language="javascript" type="text/javascript">
                window.history.forward();
            </script>
        </g:if>
    </head>

    <body>
    <div class="new-patient-questionnaire task-content">
        <div class="task-list-wrapper container">

            <form action="" method="post" data-draft="${Draft}">
                <input type="hidden" name="code" value="${taskCode}"/>
                <input type="hidden" name="taskId" value="${Task.taskId}"/>
                <input type="hidden" name="taskType" value="${Task?.type}"/>

                <div class="question-list question-1">
                    <div class="question">1. How did you first hear of us?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">Patient of us <input type="text" name="choices.1.1s" class="specify-input" placeholder="Specify"/></div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.1.c"
                                           value="1"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Internet</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.1.c"
                                           value="2"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Friend / Family member <input type="text" name="choices.1.3s" class="specify-input" placeholder="Specify"/></div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.1.c"
                                           value="3"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Physician</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.1.c"
                                           value="4"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Other <input type="text" name="choices.1.5s" class="specify-input" placeholder="Specify"/></div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.1.c"
                                           value="5"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list">
                    <div class="question">2. What is the primary reason for you visit?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">Evaluation / diagnosis / treatment</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.2"
                                           value="1"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Second opinion</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.2"
                                           value="2"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Education / information</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.2"
                                           value="3"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Surgical planning</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.2"
                                           value="4"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list question-3">
                    <div class="question">3. How long ago did your current symptoms begin?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">Less than 2 weeks ago</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.3.c"
                                           value="1"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">2 weeks to less than 8 weeks ago</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.3.c"
                                           value="2"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">8 weeks to less than 3 months ago</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.3.c"
                                           value="3"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">3 months to less than 6 months ago</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.3.c"
                                           value="4"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">6 to 12 months ago</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.3.c"
                                           value="5"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">More than 12 months ago. <input type="text" name="choices.3.6s" class="specify-input" placeholder="Enter year" /> years ago.</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.3.c"
                                           value="6"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list">
                    <div class="question">4. Please describe your current problem / symptoms?</div>

                    <div class="answer-list textarea">
                        <textarea name="choices.4" placeholder="Describe symptoms..."></textarea>
                    </div>
                </div>
                <div class="question-list">
                    <div class="question">5. What is your current work status?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">I'm not working</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.5"
                                           value="1"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">I work part-time</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.5"
                                           value="2"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">I work full-time</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.5"
                                           value="3"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list">
                    <div class="question">6. Is this a work-related injury?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">Yes</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.6"
                                           value="1"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">No</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.6"
                                           value="2"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list">
                    <div class="question">7. Have you filed a Worker's Compensation claim for your back / neck symptoms?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">Yes
                                    <span class="specify-part">
                                        Approximate Date: <input type="text" name="choices.7.1s" class="date-picker" />
                                    </span></div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.7.c"
                                           value="1"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer need-clear-inputs">
                                <div class="text">No</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.7.c"
                                           value="2"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list">
                    <div class="question">8. Have you worked with a lawyer as a result of your injury?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">Yes</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.8"
                                           value="1"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">No</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.8"
                                           value="2"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list question-9">
                    <div class="question">9. Did your pain begin after a car accident?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer answer-extension-trigger-yes">
                                <div class="text">Yes</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.9.c"
                                           value="1"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer answer-extension-trigger-no">
                                <div class="text">No</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.9.c"
                                           value="2"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                        <div class="extension-question-list hide">
                            <div class="description">If you were injured in a car accident please carefully fill out the questions below.</div>
                            <div class="extension-question">
                                <div class="extension-question-title">Date of accident:</div>
                                <div><input type="text" name="choices.9.e.1" placeholder="Pick Date" class="date-picker" /></div>
                            </div>
                            <div class="extension-question">
                                <div class="extension-question-title">Briefly describe the details of the accident:</div>
                                <textarea name="choices.9.e.2" placeholder="Describe accident..."></textarea>
                            </div>
                            <div class="extension-question">
                                <div class="extension-question-title">Describe the pattern of symptoms over the first 1 - 4 weeks after the accident:</div>
                                <textarea name="choices.9.e.3" placeholder="Describe symptoms..."></textarea>
                            </div>
                            <div class="extension-question">
                                <div class="extension-question-title">When did you first notice symptoms?</div>
                                <ul class="half-list">
                                    <li class="answer half-list-answer">
                                        <div class="text">Immediately</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.9.e.4"
                                                   value="1"
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                    <li class="answer half-list-answer">
                                        <div class="text">24 - 48 hours</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.9.e.4"
                                                   value="2"
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                    <li class="answer half-list-answer">
                                        <div class="text">3 - 7 days</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.9.e.4"
                                                   value="3"
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                </ul>
                                <ul class="half-list">
                                    <li class="answer half-list-answer">
                                        <div class="text">1 - 2 weeks</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.9.e.4"
                                                   value="4"
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                    <li class="answer half-list-answer">
                                        <div class="text">2 - 4 weeks</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.9.e.4"
                                                   value="5"
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                    <li class="answer half-list-answer">
                                        <div class="text">> 1 month</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.9.e.4"
                                                   value="6"
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                </ul>
                            </div>
                            <div class="extension-question">
                                <div class="extension-question-title">When did you first report these to a doctor?</div>
                                <div><input type="text" name="choices.9.e.5" class="specify-input whole-line" placeholder="Specify"></div>
                            </div>
                            <div class="extension-question">
                                <div class="extension-question-title">If there was a delay between the symptoms starting and your first report, please explain:</div>
                                <textarea name="choices.9.e.6" placeholder="Describe symptoms..."></textarea>
                            </div>
                            <div class="extension-question">
                                <div class="extension-question-title">Did you suffer any other injuries when you hurt your spine?</div>
                                <div>
                                    <ul class="list">
                                        <li class="answer">
                                            <div class="text">Yes <input type="text" name="choices.9.e.7.1s" class="specify-input" placeholder="List injuries"/></div>
                                            <label class="choice">
                                                <input type="radio"
                                                       class="rc-choice-hidden"
                                                       name="choices.9.e.7.c"
                                                       value="1"
                                                />
                                                <span class="rc-radio primary-radio-color"></span>
                                            </label>
                                        </li>
                                        <li class="answer need-clear-inputs">
                                            <div class="text">No</div>
                                            <label class="choice">
                                                <input type="radio"
                                                       class="rc-choice-hidden"
                                                       name="choices.9.e.7.c"
                                                       value="2"
                                                />
                                                <span class="rc-radio primary-radio-color"></span>
                                            </label>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="question-list question-10">
                    <div class="question">10. Have you ever been involved in a previous car accident?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer answer-extension-trigger-yes">
                                <div class="text">Yes
                                    <span class="specify-part">
                                        Approximate Date: <input type="text" name="choices.10.1s" class="date-picker" />
                                    </span>
                                </div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.10.c"
                                           value="1"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer answer-extension-trigger-no need-clear-inputs">
                                <div class="text">No</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.10.c"
                                           value="2"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                        <div class="extension-question-list hide">
                            <div class="extension-question">
                                <div class="extension-question-title">Was your back or neck injured?</div>
                                <div>
                                    <ul class="list">
                                        <li class="answer">
                                            <div class="text">Yes <input type="text" name="choices.10.e.1.1s" class="specify-input" placeholder="List injuries"/></div>
                                            <label class="choice">
                                                <input type="radio"
                                                       class="rc-choice-hidden"
                                                       name="choices.10.e.1.c"
                                                       value="1"
                                                />
                                                <span class="rc-radio primary-radio-color"></span>
                                            </label>
                                        </li>
                                        <li class="answer need-clear-inputs">
                                            <div class="text">No</div>
                                            <label class="choice">
                                                <input type="radio"
                                                       class="rc-choice-hidden"
                                                       name="choices.10.e.1.c"
                                                       value="2"
                                                />
                                                <span class="rc-radio primary-radio-color"></span>
                                            </label>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="extension-question">
                                <div class="extension-question-title">If yes, did the injury resolved?</div>
                                <div>
                                    <ul class="list">
                                        <li class="answer" id="accidentInjuryYes">
                                            <div class="text">Yes <input type="text" name="choices.10.e.2.1s" class="specify-input" placeholder="List injuries"/></div>
                                            <label class="choice">
                                                <input type="radio"
                                                       class="rc-choice-hidden"
                                                       name="choices.10.e.2.c"
                                                       value="1"
                                                />
                                                <span class="rc-radio primary-radio-color"></span>
                                            </label>
                                        </li>
                                        <li class="answer need-clear-inputs" id="accidentInjuryNo">
                                            <div class="text">No</div>
                                            <label class="choice">
                                                <input type="radio"
                                                       class="rc-choice-hidden"
                                                       name="choices.10.e.2.c"
                                                       value="2"
                                                />
                                                <span class="rc-radio primary-radio-color"></span>
                                            </label>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="extension-question" id="accidentInjuryQuestion">
                                <div class="extension-question-title">If that injury did <strong>NOT</strong> resolve, what treatment(s), if any, did you require on an ongoing basis?</div>
                                <textarea name="choices.10.e.3" placeholder="Physical therapy and acupuncture"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="question-list question-11">
                    <div class="question">11. Is your pain due to an injury not covered in the questions above?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer answer-extension-trigger-yes">
                                <div class="text">Yes
                                    <span class="specify-part">
                                        Date of injury: <input name="choices.11.1s" type="text" class="date-picker"/>
                                    </span></div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.11.c"
                                           value="1"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer answer-extension-trigger-no need-clear-inputs">
                                <div class="text">No</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.11.c"
                                           value="2"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                        <div class="extension-question-list hide">
                            <div class="extension-question">
                                <div class="extension-question-title">Describe the injury</div>
                                <textarea name="choices.11.e.1" placeholder="Describe injury..."></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="question-list  question-12">
                    <div class="question">12. How do each of the following activities affect your pain?</div>

                    <div class="sub-question-list">
                        <g:set var="subQuestion12" value="['Sitting', 'Walking', 'Standing', 'Lying down',
                                                           'Bending forward', 'Bending backward', 'Lifting',
                                                           'Coughing/ sneezing', 'Changing positions']"/>
                        <g:set var="subQuestion12Time" value="['5 minutes', '15 minutes', '30 minutes', '1 hour',
                                                               '2 hours', '4 hours', '8 hours']"/>
                        <g:each in="${subQuestion12}" var="subQuestion" status="j">
                            <div class="sub-question">
                                <div class="sub-question-title">${subQuestion}</div>
                                <ul class="sub-question-answer-list">
                                    <li class="sub-question-answer columns-3 question-12-no-change">
                                        <div class="text">No Change</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.12.${j}.c"
                                                   value="1"
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                    <li class="sub-question-answer columns-3 question-12-has-change">
                                        <div class="text">Relieves pain</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.12.${j}.c"
                                                   value="2"
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                    <li class="sub-question-answer columns-3 question-12-has-change">
                                        <div class="text">Increases Pain</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.12.${j}.c"
                                                   value="3"
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                </ul>
                                <div class="sub-question-time">
                                    <div class="sub-question-time-title">AFTER HOW LONG?</div>
                                    <select class="select-menu" name="choices.12.${j}.s">
                                        <g:each var="time" in="${subQuestion12Time}">
                                            <option value="">${time}</option>
                                        </g:each>
                                    </select>
                                </div>
                            </div>
                        </g:each>
                    </div>
                </div>
                <div class="question-list">
                    <div class="question">13. What other activities, motions, or positions affect your symptoms?</div>

                    <div class="answer-list textarea">
                        <textarea name="choices.13" placeholder="Describe activities..."></textarea>
                    </div>
                </div>
                <div class="question-list">
                    <div class="question">14. What do you do to relieve your pain?</div>

                    <div class="answer-list textarea">
                        <textarea name="choices.14" placeholder="Describe methods..."></textarea>
                    </div>
                </div>
                <div class="question-list">
                    <div class="question">15. Bladder function</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">Normal</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.15"
                                           value="1"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Loss of control or accidents</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.15"
                                           value="2"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Difficulty starting urination</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.15"
                                           value="3"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Sense of urgency</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.15"
                                           value="4"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Rather not answer</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.15"
                                           value="5"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list">
                    <div class="question">16. Bowel function</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">Normal</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.16"
                                           value="1"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Loss of control or accidents</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.16"
                                           value="2"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Rather not answer</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.16"
                                           value="3"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list">
                    <div class="question">17. Do you have problems with sexual function?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">Yes</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.17"
                                           value="1"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">No</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.17"
                                           value="2"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Rather not answer</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.17"
                                           value="3"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list">
                    <div class="question">18. Do you have loss of sensation around the groin, genitals or buttocks?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">Yes</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.18"
                                           value="1"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">No</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.18"
                                           value="2"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list">
                    <div class="question">19. Weakness in the leg / foot</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">Yes - right leg</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.19"
                                           value="1"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Yes - left leg</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.19"
                                           value="2"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Yes - both legs</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.19"
                                           value="3"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">No</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.19"
                                           value="4"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list">
                    <div class="question">20. Weakness in the arm / hand</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">Yes - right arm</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.20"
                                           value="1"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Yes - left arm</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.20"
                                           value="2"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Yes - both arms</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.20"
                                           value="3"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">No</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.20"
                                           value="4"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list">
                    <div class="question">21. Does your pain interfere with your sleep?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">Yes</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.21"
                                           value="1"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">No</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.21"
                                           value="2"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list question-22">
                    <div class="question">22. Which of the following treatments have you had and what was the outcome?</div>

                    <div class="sub-question-list">
                        <g:set var="subQuestion22" value="['Massage', 'Physical Therapy', 'Chiropractic Therapy', 'Spinal Injections']"/>
                        <g:each in="${subQuestion22}" var="subQuestion" status="j">
                            <div class="sub-question">
                                <div class="sub-question-title">${subQuestion}</div>
                                <ul class="sub-question-answer-list">
                                    <li class="sub-question-answer columns-4">
                                        <div class="text">N/A</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.22.${j}"
                                                   value="1"
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                    <li class="sub-question-answer columns-4">
                                        <div class="text">Helped</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.22.${j}"
                                                   value="2"
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                    <li class="sub-question-answer columns-4">
                                        <div class="text">Made me worse</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.22.${j}"
                                                   value="3"
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                    <li class="sub-question-answer columns-4">
                                        <div class="text">No difference</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.22.${j}"
                                                   value="4"
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                </ul>
                            </div>
                        </g:each>
                    </div>
                </div>
                <div class="question-list question-23" data-optional="true">
                    <div class="question">23. Please list the dates of any of the following tests you have had for your current condition in the last 2 years</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <input type="hidden" name="choices.23.1">
                                <div class="text">Regular x-rays</div>
                                <div class="multi-date-container"></div>
                            </li>
                            <li class="answer">
                                <input type="hidden" name="choices.23.2">
                                <div class="text">MRI</div>
                                <div class="multi-date-container"></div>
                            </li>
                            <li class="answer">
                                <input type="hidden" name="choices.23.3">
                                <div class="text">CT scan</div>
                                <div class="multi-date-container"></div>
                            </li>
                            <li class="answer">
                                <input type="hidden" name="choices.23.4">
                                <div class="text">Myelogram</div>
                                <div class="multi-date-container"></div>
                            </li>
                            <li class="answer">
                                <input type="hidden" name="choices.23.5">
                                <div class="text">Bone scan</div>
                                <div class="multi-date-container"></div>
                            </li>
                            <li class="answer">
                                <input type="hidden" name="choices.23.6">
                                <div class="text">EMG/NCV</div>
                                <div class="multi-date-container"></div>
                            </li>
                        </ul>
                    </div>
                </div>

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
        </div>
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








