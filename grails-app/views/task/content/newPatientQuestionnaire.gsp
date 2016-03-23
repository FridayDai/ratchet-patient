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

        @media only screen and (max-width: 767px) {
            .rc-choice-hidden:checked + .rc-radio:before, .rc-radio:hover:before {
                width: 20px!important;
                height: 20px!important;
            }
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

                <div class="question-list question-1" id="question1">
                    <div class="question">1. How did you first hear of us?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer"
                                data-trigger='{"#question1 [type=text]" : "disableOtherInputs"}'
                            >
                                <div class="text">Patient of ProOrtho <input type="text" name="choices.1-1s" class="specify-input" placeholder="Specify" maxlength="255" value="${Draft?.'1-1s'}" <g:if test="${Draft?.'1-c' && Draft?.'1-c' != 1.toString()}">disabled</g:if> /></div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.1-c"
                                           value="1"
                                           <g:if test="${Draft?.'1-c' == 1.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer"
                                data-trigger='{"#question1 [type=text]" : "disableOtherInputs"}'
                            >
                                <div class="text">Internet</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.1-c"
                                           value="2"
                                           <g:if test="${Draft?.'1-c' == 2.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer"
                                data-trigger='{"#question1 [type=text]" : "disableOtherInputs"}'
                            >
                                <div class="text">Friend / Family member <input type="text" name="choices.1-3s" class="specify-input" placeholder="Specify" maxlength="255" value="${Draft?.'1-3s'}" <g:if test="${Draft?.'1-c' && Draft?.'1-c' != 3.toString()}">disabled</g:if> /></div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.1-c"
                                           value="3"
                                           <g:if test="${Draft?.'1-c' == 3.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer"
                                data-trigger='{"#question1 [type=text]" : "disableOtherInputs"}'
                            >
                                <div class="text">Physician <input type="text" name="choices.1-4s" class="specify-input" placeholder="Specify" maxlength="255" value="${Draft?.'1-4s'}" <g:if test="${Draft?.'1-c' && Draft?.'1-c' != 4.toString()}">disabled</g:if> /></div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.1-c"
                                           value="4"
                                           <g:if test="${Draft?.'1-c' == 4.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer"
                                data-trigger='{"#question1 [type=text]" : "disableOtherInputs"}'
                            >
                                <div class="text">Other <input type="text" name="choices.1-5s" class="specify-input" placeholder="Specify" maxlength="255" value="${Draft?.'1-5s'}" <g:if test="${Draft?.'1-c' && Draft?.'1-c' != 5.toString()}">disabled</g:if> /></div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.1-c"
                                           value="5"
                                           <g:if test="${Draft?.'1-c' == 5.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list question-3" id="question3">
                    <div class="question">2. How long ago did your current symptoms begin?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer"
                                data-trigger='{"#question3 select" : "reset|disable"}'
                            >
                                <div class="text">Less than 2 weeks ago</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.3-c"
                                           value="1"
                                           <g:if test="${Draft?.'3-c' == 1.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer"
                                data-trigger='{"#question3 select" : "reset|disable"}'
                            >
                                <div class="text">2 weeks to less than 8 weeks ago</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.3-c"
                                           value="2"
                                           <g:if test="${Draft?.'3-c' == 2.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer"
                                data-trigger='{"#question3 select" : "reset|disable"}'
                            >
                                <div class="text">8 weeks to less than 3 months ago</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.3-c"
                                           value="3"
                                           <g:if test="${Draft?.'3-c' == 3.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer"
                                data-trigger='{"#question3 select" : "reset|disable"}'
                            >
                                <div class="text">3 months to less than 6 months ago</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.3-c"
                                           value="4"
                                           <g:if test="${Draft?.'3-c' == 4.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer"
                                data-trigger='{"#question3 select" : "reset|disable"}'
                            >
                                <div class="text">6 to 12 months ago</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.3-c"
                                           value="5"
                                           <g:if test="${Draft?.'3-c' == 5.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer"
                                data-trigger='{"#question3 select" : "enable"}'
                            >
                                <div class="text">
                                    <span class="inline-text">More than 12 months ago.</span>
                                    <span class="single-line">
                                        <select class="select-menu" name="choices.3-6s" data-default-text="Enter year" data-mobile-dialog-event="showEnterYearMobileDialog" <g:if test="${Draft?.'3-c' && Draft?.'3-c' != 6.toString()}">disabled</g:if>>
                                            <g:each var="time" in="${(1..10)}">
                                                <option value="${time}" <g:if test="${Draft?."3-6s" == time.toString()}">selected</g:if>>${time}</option>
                                            </g:each>
                                            <option value="15" <g:if test="${Draft?."3-6s" == 15.toString()}">selected</g:if>>15</option>
                                            <option value="20" <g:if test="${Draft?."3-6s" == 20.toString()}">selected</g:if>>20</option>
                                        </select>
                                        <span class="inline-text">year(s) ago.</span>
                                    </span>
                                </div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.3-c"
                                           value="6"
                                           <g:if test="${Draft?.'3-c' == 6.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list" id="question4">
                    <div class="question">3. Please describe your current problem / symptoms?</div>

                    <div class="answer-list textarea">
                        <textarea name="choices.4" placeholder="Describe symptoms..." maxlength="5000">${Draft?.'4'}</textarea>
                    </div>
                </div>
                <div class="question-list" id="question5">
                    <div class="question">4. What is your current work status?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">I'm not working</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.5"
                                           value="1"
                                           <g:if test="${Draft?.'5' == 1.toString()}">checked</g:if>
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
                                           <g:if test="${Draft?.'5' == 2.toString()}">checked</g:if>
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
                                           <g:if test="${Draft?.'5' == 3.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list" id="question6">
                    <div class="question">5. Is this a work-related injury?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">Yes</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.6"
                                           value="1"
                                           <g:if test="${Draft?.'6' == 1.toString()}">checked</g:if>
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
                                           <g:if test="${Draft?.'6' == 2.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list question-7" id="question7">
                    <div class="question">6. Have you filed a Worker's Compensation claim for your back / neck symptoms?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer"
                                data-trigger='{"#question7 [type=text]" : "enable"}'
                            >
                                <div class="text">Yes
                                    <span class="specify-part">
                                        <span class="label">Approximate Date:</span>
                                        <input type="text" name="choices.7-1s" class="date-picker" readonly value="${Draft?.'7-1s'}" <g:if test="${Draft?.'7-c' == 2.toString()}">disabled</g:if>/>
                                    </span>
                                </div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.7-c"
                                           value="1"
                                           <g:if test="${Draft?.'7-c' == 1.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer need-clear-inputs"
                                data-trigger='{"#question7 [type=text]" : "disable"}'
                            >
                                <div class="text">No</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.7-c"
                                           value="2"
                                           <g:if test="${Draft?.'7-c' == 2.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list" id="question8">
                    <div class="question">7. Have you worked with a lawyer as a result of your injury?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">Yes</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.8"
                                           value="1"
                                           <g:if test="${Draft?.'8' == 1.toString()}">checked</g:if>
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
                                           <g:if test="${Draft?.'8' == 2.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list question-9" id="question9">
                    <div class="question">8. Did your symptoms begin after a car accident?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer answer-extension-trigger-yes"
                                data-trigger='{"#question9-extension" : "show"}'
                            >
                                <div class="text">Yes</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.9-c"
                                           value="1"
                                           <g:if test="${Draft?.'9-c' == 1.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer answer-extension-trigger-no"
                                data-trigger='{"#question9-extension" : "hide|reset"}'
                            >
                                <div class="text">No</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.9-c"
                                           value="2"
                                           <g:if test="${Draft?.'9-c' == 2.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                        <div class="extension-question-list <g:if test="${Draft?.'9-c' != 1.toString()}">hide</g:if>" id="question9-extension">
                            <div class="description">
                                If you were injured in a car accident please carefully fill out the questions below.
                                <div class="require-statement mobile">
                                    <span>* Required field</span>
                                </div>
                            </div>
                            <div class="extension-question error-notice-field">
                                <div class="extension-question-title">Date of accident:<span class="require-mark">*</span></div>
                                <div><input type="text" name="choices.9-e-1" placeholder="Pick Date" class="date-picker" readonly value="${Draft?.'9-e-1'}"/></div>
                            </div>
                            <div class="extension-question error-notice-field">
                                <div class="extension-question-title">Briefly describe the details of the accident:</div>
                                <textarea name="choices.9-e-2" placeholder="Describe accident..." maxlength="5000">${Draft?.'9-e-2'}</textarea>
                            </div>
                            <div class="extension-question error-notice-field">
                                <div class="extension-question-title">Describe the pattern of symptoms over the first 1 - 4 weeks after the accident:</div>
                                <textarea name="choices.9-e-3" placeholder="Describe symptoms..." maxlength="5000">${Draft?.'9-e-3'}</textarea>
                            </div>
                            <div class="extension-question radio-group error-notice-field">
                                <div class="extension-question-title">When did you first notice symptoms?<span class="require-mark">*</span></div>
                                <ul class="half-list">
                                    <li class="answer half-list-answer">
                                        <div class="text">Immediately</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.9-e-4"
                                                   value="1"
                                                   <g:if test="${Draft?.'9-e-4' == 1.toString()}">checked</g:if>
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                    <li class="answer half-list-answer">
                                        <div class="text">24 - 48 hours</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.9-e-4"
                                                   value="2"
                                                   <g:if test="${Draft?.'9-e-4' == 2.toString()}">checked</g:if>
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                    <li class="answer half-list-answer">
                                        <div class="text">3 - 7 days</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.9-e-4"
                                                   value="3"
                                                   <g:if test="${Draft?.'9-e-4' == 3.toString()}">checked</g:if>
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
                                                   name="choices.9-e-4"
                                                   value="4"
                                                   <g:if test="${Draft?.'9-e-4' == 4.toString()}">checked</g:if>
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                    <li class="answer half-list-answer">
                                        <div class="text">2 - 4 weeks</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.9-e-4"
                                                   value="5"
                                                   <g:if test="${Draft?.'9-e-4' == 5.toString()}">checked</g:if>
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                    <li class="answer half-list-answer">
                                        <div class="text">> 1 month</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.9-e-4"
                                                   value="6"
                                                   <g:if test="${Draft?.'9-e-4' == 6.toString()}">checked</g:if>
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                </ul>
                            </div>
                            <div class="extension-question error-notice-field">
                                <div class="extension-question-title">When did you first report these to a doctor?</div>
                                <div><input type="text" name="choices.9-e-5" class="specify-input whole-line" placeholder="Specify" maxlength="255" value="${Draft?.'9-e-5'}"></div>
                            </div>
                            <div class="extension-question">
                                <div class="extension-question-title">If there was a delay between the symptoms starting and your first report, please explain:</div>
                                <textarea name="choices.9-e-6" placeholder="Explain delay..." maxlength="5000">${Draft?.'9-e-6'}</textarea>
                            </div>
                            <div class="extension-question radio-choice error-notice-field">
                                <div class="extension-question-title">Did you suffer any other injuries when you hurt your spine?<span class="require-mark">*</span></div>
                                <div>
                                    <ul class="list">
                                        <li class="answer" id="question9-extension7-yes"
                                            data-trigger='{"#question9-extension7-yes [type=text]": "enable"}'
                                        >
                                            <div class="text">Yes <input type="text" name="choices.9-e-7-1s" class="specify-input" placeholder="List injuries" maxlength="255" <g:if test="${Draft?.'9-e-7-c' == 2.toString()}">disabled</g:if> value="${Draft?.'9-e-7-1s'}"/></div>
                                            <label class="choice">
                                                <input type="radio"
                                                       class="rc-choice-hidden"
                                                       name="choices.9-e-7-c"
                                                       value="1"
                                                       <g:if test="${Draft?.'9-e-7-c' == 1.toString()}">checked</g:if>
                                                />
                                                <span class="rc-radio primary-radio-color"></span>
                                            </label>
                                        </li>
                                        <li class="answer need-clear-inputs"
                                            data-trigger='{"#question9-extension7-yes [type=text]": "disable|clearOtherInputs"}'
                                        >
                                            <div class="text">No</div>
                                            <label class="choice">
                                                <input type="radio"
                                                       class="rc-choice-hidden"
                                                       name="choices.9-e-7-c"
                                                       value="2"
                                                       <g:if test="${Draft?.'9-e-7-c' == 2.toString()}">checked</g:if>
                                                />
                                                <span class="rc-radio primary-radio-color"></span>
                                            </label>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="require-statement tablet">
                                <span>* Required field</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="question-list question-12" id="question12">
                    <div class="question">9. How do each of the following activities affect your pain?</div>

                    <div class="sub-question-list">
                        <g:set var="subQuestion12" value="['Sitting', 'Walking', 'Standing', 'Lying down',
                                                           'Bending forward', 'Bending backward', 'Lifting',
                                                           'Coughing/ sneezing', 'Changing positions']"/>
                        <g:set var="subQuestion12Time" value="['5 minutes', '15 minutes', '30 minutes', '1 hour',
                                                               '2 hours', '4 hours', '8 hours']"/>
                        <g:each in="${subQuestion12}" var="subQuestion" status="j">
                            <div class="sub-question error-notice-field">
                                <div class="sub-question-title">${subQuestion}</div>
                                <ul class="sub-question-answer-list">
                                    <li class="sub-question-answer columns-3 question-12-no-change column-1st"
                                        data-trigger='{"#question12Sub${j}Select" : "disable|mobileHideSelect"}'
                                    >
                                        <div class="text">No Change</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.12-${j}-c"
                                                   value="1"
                                                   <g:if test="${Draft?."12-${j}-c" == 1.toString()}">checked</g:if>
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                    <li class="sub-question-answer columns-3 question-12-has-change column-2nd"
                                        data-trigger='{"#question12Sub${j}Select" : "enable|mobileShowSelectAtOwn"}'
                                    >
                                        <div class="text">Relieves Pain</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.12-${j}-c"
                                                   value="2"
                                                   <g:if test="${Draft?."12-${j}-c" == 2.toString()}">checked</g:if>
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                    <li class="sub-question-answer columns-3 question-12-has-change column-3rd"
                                        data-trigger='{"#question12Sub${j}Select" : "enable|mobileShowSelectAtOwn"}'
                                    >
                                        <div class="text">Increases Pain</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.12-${j}-c"
                                                   value="3"
                                                   <g:if test="${Draft?."12-${j}-c" == 3.toString()}">checked</g:if>
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                </ul>
                                <div class="sub-question-time">
                                    <div class="sub-question-time-title">AFTER HOW LONG?<span class="optional">(Optional)</span></div>
                                    <select class="select-menu" name="choices.12-${j}-s" id="question12Sub${j}Select"
                                        data-default-text="Pick Time" data-default-text-mobile="Pick Time (Optional)" data-mobile-dialog-event="showPickTimeMobileDialog"
                                            <g:if test="${Draft?."12-${j}-c" == 1.toString()}">disabled</g:if>
                                    >
                                        <g:each var="time" in="${subQuestion12Time}" status="h">
                                            <option value="${h}" <g:if test="${Draft?."12-${j}-s" == h.toString()}">selected</g:if>>${time}</option>
                                        </g:each>
                                    </select>
                                </div>
                            </div>
                        </g:each>
                    </div>
                </div>
                <div class="question-list" id="question13">
                    <div class="question">10. What other activities, motions, or positions affect your symptoms?</div>

                    <div class="answer-list textarea">
                        <textarea name="choices.13" placeholder="Describe activities..." maxlength="5000">${Draft?.'13'}</textarea>
                    </div>
                </div>
                <div class="question-list" id="question14">
                    <div class="question">11. What do you do to relieve your pain?</div>

                    <div class="answer-list textarea">
                        <textarea name="choices.14" placeholder="Describe methods..." maxlength="5000">${Draft?.'14'}</textarea>
                    </div>
                </div>
                <div class="question-list" id="question15">
                    <div class="question">12. Bladder function</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">Normal</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.15"
                                           value="1"
                                           <g:if test="${Draft?."15" == 1.toString()}">checked</g:if>
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
                                           <g:if test="${Draft?."15" == 2.toString()}">checked</g:if>
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
                                           <g:if test="${Draft?."15" == 3.toString()}">checked</g:if>
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
                                           <g:if test="${Draft?."15" == 4.toString()}">checked</g:if>
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
                                           <g:if test="${Draft?."15" == 5.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list" id="question16">
                    <div class="question">13. Bowel function</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">Normal</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.16"
                                           value="1"
                                           <g:if test="${Draft?."16" == 1.toString()}">checked</g:if>
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
                                           <g:if test="${Draft?."16" == 2.toString()}">checked</g:if>
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
                                           <g:if test="${Draft?."16" == 3.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list" id="question17">
                    <div class="question">14. Problem with sexual function:</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">No</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.17"
                                           value="1"
                                           <g:if test="${Draft?."17" == 1.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Yes</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.17"
                                           value="2"
                                           <g:if test="${Draft?."17" == 2.toString()}">checked</g:if>
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
                                           <g:if test="${Draft?."17" == 3.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list" id="question18">
                    <div class="question">15. Loss of sensation around the groin, genitals, or buttocks?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">No</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.18"
                                           value="1"
                                           <g:if test="${Draft?."18" == 1.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Yes</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.18"
                                           value="2"
                                           <g:if test="${Draft?."18" == 2.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list" id="question19">
                    <div class="question">16. Weakness in the leg / foot</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">No</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.19"
                                           value="1"
                                           <g:if test="${Draft?."19" == 1.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Yes - right leg</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.19"
                                           value="2"
                                           <g:if test="${Draft?."19" == 2.toString()}">checked</g:if>
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
                                           value="3"
                                           <g:if test="${Draft?."19" == 3.toString()}">checked</g:if>
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
                                           value="4"
                                           <g:if test="${Draft?."19" == 4.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list" id="question20">
                    <div class="question">17. Weakness in the arm / hand</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">No</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.20"
                                           value="1"
                                           <g:if test="${Draft?."20" == 1.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Yes - right arm</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.20"
                                           value="2"
                                           <g:if test="${Draft?."20" == 2.toString()}">checked</g:if>
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
                                           value="3"
                                           <g:if test="${Draft?."20" == 3.toString()}">checked</g:if>
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
                                           value="4"
                                           <g:if test="${Draft?."20" == 4.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list" id="question21">
                    <div class="question">18. Does your pain interfere with your sleep?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <div class="text">No</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.21"
                                           value="1"
                                           <g:if test="${Draft?."21" == 1.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer">
                                <div class="text">Yes</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.21"
                                           value="2"
                                           <g:if test="${Draft?."21" == 2.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list question-22" id="question22">
                    <div class="question">19. Which of the following treatments have you had and what was the outcome?</div>

                    <div class="sub-question-list">
                        <g:set var="subQuestion22" value="['Massage', 'Physical Therapy', 'Chiropractic Therapy', 'Spinal Injections']"/>
                        <g:each in="${subQuestion22}" var="subQuestion" status="j">
                            <div class="sub-question error-notice-field">
                                <div class="sub-question-title">${subQuestion}</div>
                                <ul class="sub-question-answer-list">
                                    <li class="sub-question-answer columns-4">
                                        <div class="text">N/A</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.22-${j}"
                                                   value="1"
                                                   <g:if test="${Draft?."22-${j}" == 1.toString()}">checked</g:if>
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                    <li class="sub-question-answer columns-4">
                                        <div class="text">Helped</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.22-${j}"
                                                   value="2"
                                                   <g:if test="${Draft?."22-${j}" == 2.toString()}">checked</g:if>
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                    <li class="sub-question-answer columns-4">
                                        <div class="text">Made me worse</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.22-${j}"
                                                   value="3"
                                                   <g:if test="${Draft?."22-${j}" == 3.toString()}">checked</g:if>
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                    <li class="sub-question-answer columns-4">
                                        <div class="text">No difference</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.22-${j}"
                                                   value="4"
                                                   <g:if test="${Draft?."22-${j}" ==4.toString()}">checked</g:if>
                                            />
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                </ul>
                            </div>
                        </g:each>
                    </div>
                </div>
                <div class="question-list question-23" data-optional="true" id="question23">
                    <div class="question">20. Please list the dates of any of the following tests you have had for your current condition in the last 2 years</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="sub-question error-notice-field">
                                <input type="hidden" name="choices.23-1" value="${Draft?.'23-1'}">
                                <div class="text">Regular x-rays</div>
                                <div class="multi-date-container" data-init="${Draft?.'23-1'}"></div>
                            </li>
                            <li class="sub-question error-notice-field">
                                <input type="hidden" name="choices.23-2" value="${Draft?.'23-2'}">
                                <div class="text">MRI</div>
                                <div class="multi-date-container" data-init="${Draft?.'23-2'}"></div>
                            </li>
                            <li class="sub-question error-notice-field">
                                <input type="hidden" name="choices.23-3" value="${Draft?.'23-3'}">
                                <div class="text">CT scan</div>
                                <div class="multi-date-container" data-init="${Draft?.'23-3'}"></div>
                            </li>
                            <li class="sub-question error-notice-field">
                                <input type="hidden" name="choices.23-4" value="${Draft?.'23-4'}">
                                <div class="text">Myelogram</div>
                                <div class="multi-date-container" data-init="${Draft?.'23-4'}"></div>
                            </li>
                            <li class="sub-question error-notice-field">
                                <input type="hidden" name="choices.23-5" value="${Draft?.'23-5'}">
                                <div class="text">Bone scan</div>
                                <div class="multi-date-container" data-init="${Draft?.'23-5'}"></div>
                            </li>
                            <li class="sub-question error-notice-field">
                                <input type="hidden" name="choices.23-6" value="${Draft?.'23-6'}">
                                <div class="text">EMG/NCV</div>
                                <div class="multi-date-container" data-init="${Draft?.'23-6'}"></div>
                            </li>
                        </ul>
                    </div>
                </div>

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
                    <input type="submit" class="rc-btn task-done-btn" value="I'm Done">
                </div>
            </form>
            <div id="mobile-date-picker-dialog" class="modal ui-hidden" data-change-month="true" data-change-year="true">
                <div class="inline-date-picker" autofocus></div>
            </div>
            <div id="mobile-enter-year-dialog" class="modal ui-hidden" data-title="Select year">
                <div class="answer-list" autofocus>
                    <ul class="list">
                        <g:each var="j" in="${1..<13}">
                            <li class="answer">
                                <div class="text"><g:if test="${j > 10}">${5 * j - 40}</g:if><g:else>${j}</g:else> year<g:if test="${j > 1}">s</g:if></div>
                                <label class="choice">
                                    <input type="radio"
                                           data-index="${j - 1}"
                                           class="rc-choice-hidden"
                                           name="mobileEnterYear"
                                           value="<g:if test="${j > 10}">${5 * j - 40}</g:if><g:else>${j}</g:else>"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </g:each>
                    </ul>
                </div>
            </div>
            <div id="mobile-multiple-date-dialog" class="modal ui-hidden" data-title="Add Date">
                <div class="picker-container" autofocus>
                </div>
            </div>
            <div id="mobile-pick-time-dialog" class="modal ui-hidden" data-title="Select a length of time">
                <div class="answer-list" autofocus>
                    <ul class="list">
                        <g:set var="timeArr" value="['5 minutes', '15 minutes', '30 minutes', '1 hour', '2 hours', '4 hours', '8 hours']" />
                        <g:each var="time" in="${timeArr}" status="index">
                            <li class="answer">
                                <div class="text">${time}</div>
                                <label class="choice">
                                    <input type="radio"
                                            data-index="${index}"
                                           class="rc-choice-hidden"
                                           name="mobileEnterYear"
                                           value="${index}"
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </g:each>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <g:render template="/shared/copyRight" />
    <g:render template="/shared/pageMask" />
    </body>
    </html>
    <content tag="GA">
        <script>
            ga('send', 'event', '${taskTitle}', 'in progress', '${taskCode}');
        </script>
    </content>
</g:applyLayout>
