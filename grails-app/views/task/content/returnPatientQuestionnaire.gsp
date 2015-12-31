<g:set var="commonScriptPath" value="dist/commons.chunk.js"/>
<g:set var="scriptPath" value="dist/returnPatientQuestionnaireTool.bundle.js"/>
<g:set var="cssPath" value="task/returnPatientQuestionnaire"/>
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

        .rc-choice-hidden:checked + .rc-radio:before,
        .rc-radio:hover:before,
        .rc-choice-hidden:checked + .rc-checkbox:before,
        .rc-checkbox:hover:before {
            background-color: ${     client.primaryColorHex?:'#0f137d'     } !important;
            width: 21px!important;
            height: 21px!important;
        }

        @media only screen and (max-width: 767px) {
            .rc-choice-hidden:checked + .rc-radio:before,
            .rc-radio:hover:before,
            .rc-choice-hidden:checked + .rc-checkbox:before,
            .rc-checkbox:hover:before {
                width: 20px!important;
                height: 20px!important;
            }
        }
        </style>

        <g:if test="${isInClinic}">
            <script language="javascript" type="text/javascript">
                window.history.forward();
            </script>
        </g:if>
    </head>

    <body>
    <div class="return-patient-questionnaire task-content">
        <div class="task-list-wrapper container">

            <form action="" method="post" data-draft="${Draft}">
                <input type="hidden" name="code" value="${taskCode}"/>
                <input type="hidden" name="taskId" value="${Task.taskId}"/>
                <input type="hidden" name="taskType" value="${Task?.type}"/>

                <div class="question-list question-1" id="question1">
                    <div class="question">1. What is the purpose of your visit today?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer"
                                data-trigger='{"#question1 [type=text]" : "disableOtherInputs"}'
                            >
                                <div class="text">Review imaging studies <span class="explain-part">(e.g., x-rays, MRI, CT, etc ... )</span></div>
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
                                <div class="text">Review injection results <span class="explain-part">(</span>
                                    <span class="specify-part">
                                        <span class="label">Injection date:</span>
                                        <input type="text" name="choices.1-2s" class="date-picker" readonly <g:if test="${Draft?.'1-c' && Draft?.'1-c' != 2.toString()}">disabled</g:if> value="${Draft?.'1-2s'}"/>
                                    </span>
                                    <span class="explain-part">)</span>
                                </div>
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
                                <div class="text">Routine follow-up</div>
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
                                <div class="text">Post-operative follow-up <span class="explain-part">(</span>
                                    <span class="specify-part">
                                        <span class="label">Surgery date:</span>
                                        <input type="text" name="choices.1-4s" class="date-picker" readonly <g:if test="${Draft?.'1-c' && Draft?.'1-c' != 4.toString()}">disabled</g:if> value="${Draft?.'1-4s'}"/>
                                    </span>
                                    <span class="explain-part">)</span>
                                </div>
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
                                <div class="text">Medication renewal</div>
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
                            <li class="answer"
                                data-trigger='{"#question1 [type=text]" : "disableOtherInputs"}'
                            >
                                <div class="text">Other <input type="text" name="choices.1-6s" class="specify-input" placeholder="Specify" maxlength="255" value="${Draft?.'1-6s'}" <g:if test="${Draft?.'1-c' && Draft?.'1-c' != 6.toString()}">disabled</g:if> /></div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.1-c"
                                           value="6"
                                           <g:if test="${Draft?.'1-c' == 6.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="question-list" id="question2">
                    <div class="question">2. Compared to your last visit, are your symptoms?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer"
                                data-trigger='{"#question2-extension" : "show"}'
                            >
                                <div class="text">Improved</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.2-c"
                                           value="1"
                                           <g:if test="${Draft?.'2-c' == 1.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer"
                                data-trigger='{"#question2-extension" : "hide|reset"}'
                            >
                                <div class="text">Worse</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.2-c"
                                           value="2"
                                           <g:if test="${Draft?.'2-c' == 2.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer"
                                data-trigger='{"#question2-extension" : "hide|reset"}'
                            >
                                <div class="text">Same</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.2-c"
                                           value="3"
                                           <g:if test="${Draft?.'2-c' == 3.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                            <li class="answer"
                                data-trigger='{"#question2-extension" : "hide|reset"}'
                            >
                                <div class="text">Different</div>
                                <label class="choice">
                                    <input type="radio"
                                           class="rc-choice-hidden"
                                           name="choices.2-c"
                                           value="4"
                                           <g:if test="${Draft?.'2-c' == 4.toString()}">checked</g:if>
                                    />
                                    <span class="rc-radio primary-radio-color"></span>
                                </label>
                            </li>
                        </ul>
                        <div class="extension-question-list <g:if test="${Draft?.'2-c' != 1.toString()}">hide</g:if>" id="question2-extension">
                            <div class="extension-question error-notice-field">
                                <div class="extension-question-title">By what percent are they better? (100% would be complete improvement)</div>
                                <div>
                                    <ul class="half-list">
                                        <li class="answer half-list-answer">
                                            <div class="text">0 - 24%</div>
                                            <label class="choice">
                                                <input type="radio"
                                                       class="rc-choice-hidden"
                                                       name="choices.2-e-1"
                                                       value="1"
                                                       <g:if test="${Draft?.'2-e-1' == 1.toString()}">checked</g:if>
                                                />
                                                <span class="rc-radio primary-radio-color"></span>
                                            </label>
                                        </li>
                                        <li class="answer half-list-answer">
                                            <div class="text">25 - 49%</div>
                                            <label class="choice">
                                                <input type="radio"
                                                       class="rc-choice-hidden"
                                                       name="choices.2-e-1"
                                                       value="2"
                                                       <g:if test="${Draft?.'2-e-1' == 2.toString()}">checked</g:if>
                                                />
                                                <span class="rc-radio primary-radio-color"></span>
                                            </label>
                                        </li>
                                    </ul>
                                    <ul class="half-list">
                                        <li class="answer half-list-answer">
                                            <div class="text">50 - 74%</div>
                                            <label class="choice">
                                                <input type="radio"
                                                       class="rc-choice-hidden"
                                                       name="choices.2-e-1"
                                                       value="3"
                                                       <g:if test="${Draft?.'2-e-1' == 3.toString()}">checked</g:if>
                                                />
                                                <span class="rc-radio primary-radio-color"></span>
                                            </label>
                                        </li>
                                        <li class="answer half-list-answer">
                                            <div class="text">75 - 100%</div>
                                            <label class="choice">
                                                <input type="radio"
                                                       class="rc-choice-hidden"
                                                       name="choices.2-e-1"
                                                       value="4"
                                                       <g:if test="${Draft?.'2-e-1' == 4.toString()}">checked</g:if>
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
                <div class="question-list question-3" id="question3">
                    <div class="question">3. What is your current work status?</div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer"
                                data-trigger='{"#question3-extension" : "hide|reset"}'
                            >
                                <div class="text">I’m not working</div>
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
                                data-trigger='{"#question3-extension" : "show"}'
                            >
                                <div class="text">I work part-time</div>
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
                                data-trigger='{"#question3-extension" : "show"}'
                            >
                                <div class="text">I work full-time</div>
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
                        </ul>
                        <div class="extension-question-list <g:if test="${Draft?.'3-c' != 2.toString() && Draft?.'3-c' != 3.toString()}">hide</g:if>" id="question3-extension">
                            <div class="extension-question error-notice-field">
                                <div class="extension-question-title">Did you take time off from work?</div>
                                <div>
                                    <ul class="list">
                                        <li class="answer"
                                            data-trigger='{"#question3-extension [type=text]" : "enable"}'
                                        >
                                            <div class="text">Yes
                                                <span class="specify-part">
                                                    <span class="label">Return date:</span>
                                                    <input type="text" name="choices.3-e-1s" class="date-picker" readonly <g:if test="${Draft?.'3-e-1-c' && Draft?.'3-e-1-c' != 1.toString()}">disabled</g:if> value="${Draft?.'3-e-1s'}"/>
                                                </span>
                                            </div>
                                            <label class="choice">
                                                <input type="radio"
                                                       class="rc-choice-hidden"
                                                       name="choices.3-e-1-c"
                                                       value="1"
                                                       <g:if test="${Draft?.'3-e-1-c' == 1.toString()}">checked</g:if>
                                                />
                                                <span class="rc-radio primary-radio-color"></span>
                                            </label>
                                        </li>
                                        <li class="answer need-clear-inputs"
                                            data-trigger='{"#question3 [type=text]" : "disableOtherInputs"}'
                                        >
                                            <div class="text">No</div>
                                            <label class="choice">
                                                <input type="radio"
                                                       class="rc-choice-hidden"
                                                       name="choices.3-e-1-c"
                                                       value="2"
                                                       <g:if test="${Draft?.'3-e-1-c' == 2.toString()}">checked</g:if>
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
                <div class="question-list question-4" id="question4">
                    <div class="question">4. Review of Systems– Please mark the circle next to ANY symptoms you have experienced in the <strong>past 6 months</strong>:</div>

                    <div class="sub-question-list">
                        <g:set var="subQuestion4" value="${[['Constitutional', [
                                'recent weight gain > 10 lbs',
                                'recent weight loss > 10 lbs',
                                'loss of appetite',
                                'fatigue',
                                'insomnia',
                                'fever/ chills',
                                'night sweats'
                        ]], ['Eyes/ Ears', [
                                'eye disease',
                                'glasses or contacts',
                                'blurred or double vision',
                                'vision loss',
                                'hearing loss',
                                'ringing in the ears'
                        ]], ['Nose', [
                                'sinus problems',
                                'nose bleeds'
                        ]], ['Throat/ Mouth', [
                                'sore throat',
                                'mouth sores',
                                'hoarseness',
                                'sleep apnea',
                                'swollen glands in the neck'
                        ]], ['Cardiovascular', [
                                'heart trouble',
                                'chest pain',
                                'heart murmur',
                                'palpitations',
                                'irregular heartbeat',
                                'varicose veins',
                                'swelling of the feet / ankles'
                        ]], ['Respiratory', [
                                'shortness of breath',
                                'wheezing',
                                'chronic cough',
                                'COPD / emphysema'
                        ]], ['Hematologic', [
                                'bleeding tendency',
                                'anemia',
                                'recurrent infections'
                        ]], ['Endocrine', [
                                'thyroid problems',
                                'heat or cold intolerance',
                                'excessive thirst / appetite',
                                'diabetes',
                                'glandular or hormone problems'
                        ]], ['Gastrointestinal', [
                                'nausea / vomiting',
                                'constipation',
                                'diarrhea',
                                'blood in your stool',
                                'loss of bowel control',
                                'abdominal pain'
                        ]], ['Genitourinary', [
                                'blood in your urine',
                                'increased frequency of urination',
                                'urgency of urination',
                                'painful urination',
                                'loss of bladder control',
                                'kidney stones',
                                'incontinence',
                                'sexual difficulty'
                        ]], ['Musculoskeletal', [
                                'fractures / sprains',
                                'osteoporosis',
                                'joint swelling',
                                'joint pain',
                                'weakness of muscles or joints',
                                'muscle pain or cramps',
                                'back pain',
                                'difficulty walking'
                        ]], ['Skin', [
                                'rashes',
                                'psoriasis',
                                'bruise easily',
                                'abnormal lumps',
                                'painful breasts',
                                'change of skin color',
                                'change in hair or nails'
                        ]], ['Neurologic', [
                                'headache / migraine',
                                'dizziness',
                                'convulsions / seizures',
                                'loss of consciousness'
                        ]], ['Mental health', [
                                'depression',
                                'nervousness',
                                'hallucinations',
                                'anxiety',
                                'unusual stress in home life',
                                'unusual stress in work life'
                        ]]]}"/>
                        <g:each in="${subQuestion4}" var="subQuestion" status="j">
                            <div class="sub-question error-notice-field">
                                <div class="sub-question-title">${subQuestion[0]}</div>
                                <ul class="sub-question-answer-list">
                                    <g:each in="${subQuestion[1]}" var="subAnswer" status="index">
                                    <li class="answer sub-question-answer answer-multiple answer-multiple-${j}"
                                        data-trigger='{"#question4 .answer-none-${j} [type=checkbox]" : "checkboxToggle", "#question4 .answer-multiple-${j} [type=checkbox]" : "enable"}'
                                    >
                                        <div class="text">${subAnswer}</div>
                                        <label class="choice <g:if test="${Draft?."4-${j}"?.indexOf((subQuestion[1].size() + 1).toString()) > -1}">disabled</g:if>">
                                            <input type="checkbox"
                                                   class="rc-choice-hidden"
                                                   name="choices.4-${j}"
                                                   value="${index + 1}"
                                                   <g:if test="${Draft?."4-${j}"?.indexOf((index + 1).toString()) > -1}">checked</g:if>
                                            />
                                            <span class="rc-checkbox primary-radio-color"></span>
                                        </label>
                                    </li>
                                    </g:each>
                                    <li class="answer sub-question-answer answer-none answer-none-${j}"
                                        data-trigger='{"#question4 .answer-multiple-${j} [type=checkbox]" : "checkboxToggle", "#question4 .answer-none-${j} [type=checkbox]" : "enable"}'
                                    >
                                        <div class="text">none of the above</div>
                                        <label class="choice <g:if test="${Draft?."4-${j}"?.indexOf((subQuestion[1].size() + 1).toString()) == -1}">disabled</g:if>">
                                            <input type="checkbox"
                                                   class="rc-choice-hidden"
                                                   name="choices.4-${j}"
                                                   value="${subQuestion[1].size() + 1}"
                                                   <g:if test="${Draft?."4-${j}"?.indexOf((subQuestion[1].size() + 1).toString()) > -1}">checked</g:if>
                                            />
                                            <span class="rc-checkbox primary-radio-color"></span>
                                        </label>
                                    </li>
                                </ul>
                            </div>
                        </g:each>
                        <div class="sub-question">
                            <div class="sub-question-title">Other:</div>
                            <div class="textarea-container">
                                <textarea placeholder="List symptoms..." maxlength="5000">${Draft?."4-14"}</textarea>
                            </div>
                        </div>
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
            <div id="mobile-date-picker-dialog" class="modal ui-hidden">
                <div class="inline-date-picker" autofocus></div>
            </div>
        </div>
    </div>

    <g:render template="/shared/pageMask"></g:render>

    <script>
        function detectmob() {
            if( navigator.userAgent.match(/Android/i)
                    || navigator.userAgent.match(/webOS/i)
                    || navigator.userAgent.match(/iPhone/i)
                    || navigator.userAgent.match(/iPad/i)
                    || navigator.userAgent.match(/iPod/i)
                    || navigator.userAgent.match(/BlackBerry/i)
                    || navigator.userAgent.match(/Windows Phone/i)
            ){
                return true;
            }
            else {
                return false;
            }
        }

        if (!detectmob()) {
            var css =
                    ".rc-checkbox:hover:before {" +
                        "position: absolute;" +
                        "top: 2px;" +
                        "left: 2px;" +
                        "display: block;" +
                        "width: 25px;" +
                        "height: 25px;" +
                        "border-radius: 50%;" +
                        "content: '';" +
                    "}" +
                    "@media only screen and (max-width: 767px) {" +
                        ".rc-checkbox:hover:before {" +
                            "width: 20px;" +
                            "height: 20px;" +
                        "}" +
                    "}" +
                    ".rc-checkbox:hover:before {" +
                        "background-color: ${client.primaryColorHex?:'#0f137d'} !important;"  +
                    "}" +
                    ".rc-checkbox:hover:after {" +
                        "position: absolute;" +
                        "top: 3px;" +
                        "left: 6px;" +
                        "display: inline-block;" +
                        "content: '\\f383';" +
                        "font-family: 'Ionicons';" +
                        "font-size: 18px;" +
                        "color: #fff;" +
                    "}";

            var head = document.head || document.getElementsByTagName('head')[0];
            var style = document.createElement('style');

            style.type = 'text/css';
            if (style.styleSheet){
                style.styleSheet.cssText = css;
            } else {
                style.appendChild(document.createTextNode(css));
            }

            head.appendChild(style);
        }
    </script>
    </body>
    </html>
    <content tag="GA">
        <script>
            ga('send', 'event', '${taskTitle}', 'in progress', '${taskCode}');
        </script>
    </content>
</g:applyLayout>
