<%@ page import="com.ratchethealth.patient.RatchetStatusCode" %>
<g:set var="commonScriptPath" value="dist/commons.chunk.js"/>
<g:set var="scriptPath" value="dist/promisTool.bundle.js"/>
<g:set var="cssPath" value="task/promis"/>


<g:if test="${!isInClinic}">
    <g:set var="hasAssistMe" value="true"/>
</g:if>
<g:applyLayout name="taskContent">
    <html>
    <head>
        <title>${Task.title}</title>

        <style type="text/css">
        @media only screen and (max-width: 767px) {
            .task-time {
                color: ${ client.primaryColorHex?:'#0f137d' } !important;
            }

            .task-content .question {
                color: ${ client.primaryColorHex?:'#0f137d' } !important;
            }
        }

        .primary-color {
            color: ${ client.primaryColorHex?:'#0f137d' } !important;
        }

        .primary-border-color {
            border-color: ${ client.primaryColorHex?:'#0f137d' } !important;
        }

        .primary-background-color {
            background-color: ${ client.primaryColorHex?:'#0f137d' } !important;
        }

        .task-done-btn {
            color: ${ client.primaryColorHex?:'#0f137d' } !important;
            border-color: ${ client.primaryColorHex?:'#0f137d' } !important;;
        }

        .task-done-btn:hover {
            color: #ffffff !important;
            background-color: ${ client.primaryColorHex?:'#0f137d' } !important;
        }

        .rc-choice-hidden:checked + .rc-radio:before, .rc-radio:hover:before {
            background-color: ${ client.primaryColorHex?:'#0f137d' } !important;
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
    <div class="promis task-content">

        <form id="promis" name="promis" method="post">
            <input type="hidden" name="code" value="${taskCode}"/>
            <input type="hidden" name="taskId" value="${Task.taskId}"/>
            <input type="hidden" name="taskType" value="${Task.type}"/>

            <div class="task-list-wrapper container">
                <g:each var="section" in="${Task.sections}" status="i">

                    <div id="section-id-${section.id}" class="section-list" value="${section.id}">

                        <g:if test="${i==1}">
                            <span class="tip">In the past 7 days...</span>
                        </g:if>

                        <g:each var="question" in="${section.questions}" status="j">
                            <g:if test="${question.order < 10}">
                                <div class="question-list <g:if test="${errors && errors["${question?.id}"]}">error</g:if>">
                                    <input type="hidden" name="optionals.${question?.id}"
                                           value="${question.optional ? '0' : '1'}"/>

                                    <div class="question">
                                        <span class="question-title">Global ${question.order}.</span> ${raw(question.title)}
                                        <g:if test="${errors && errors["${question?.id}"]}">
                                            <span class="error-label">This question is required.</span>
                                        </g:if>
                                    </div>

                                    <g:hiddenField name="sections.${section.id}" value="${question?.id}"></g:hiddenField>

                                    <div class="answer-list answer-list-${question.order}">
                                        <ul class="list horizontal-list">
                                            <g:each var="choice" in="${question.choices}">
                                                <li class="answer">
                                                    <div class="text">${choice.content}</div>
                                                    <label class="choice">
                                                        <input type="radio" class="rc-choice-hidden"
                                                               name="choices.${question?.id}"
                                                               value="${choice.id}.${choice.sequence}"
                                                               <g:if test="${(choices && choices["${question.id}"]?.endsWith(choice.sequence)) ||
                                                                       choice.id == question.draftChoice}">checked
                                                               </g:if>/>
                                                        <span class="rc-radio"></span>
                                                    </label>
                                                </li>
                                            </g:each>
                                        </ul>
                                    </div>
                                </div>
                            </g:if>

                            <g:else>
                                <div class="question-list <g:if test="${errors && errors["${question?.id}"]}">error</g:if>">

                                    <div class="question">
                                        <span class="question-title">Global ${question.order}.</span> ${raw(question.title)}
                                        <g:if test="${errors && errors["${question?.id}"]}">
                                            <span class="error-label">This question is required.</span>
                                        </g:if>
                                    </div>

                                    <div class="answer-list nrs">
                                        <div class="answer-description">
                                            <span class="no-pain">No Pain</span>
                                            <span class="severe-pain">Severe Pain</span>
                                        </div>
                                        <ul class="list">
                                            <g:each var="k" in="${(0..<11)}">
                                                <li class="answer">
                                                    <div class="text">
                                                        ${k} -
                                                        <g:if test="${k == 0}">No Pain</g:if>
                                                        <g:if test="${k >= 1 && k < 4}">Mid Pain</g:if>
                                                        <g:if test="${k >= 4 && k < 7}">Moderate Pain</g:if>
                                                        <g:if test="${k >= 7 && k < 11}">Severe Pain</g:if>
                                                    </div>
                                                    <label class="choice choice-number choice-number-${k}">
                                                        <input type="radio" class="rc-choice-hidden"
                                                               name="choices.${10 + 2 * i}"
                                                            <g:if test="${Draft != null && Draft[(10 + 2 * i).toString()] == k.toString()}">checked</g:if>
                                                               value="${k}"/>
                                                        <span class="rc-radio"></span>
                                                    </label>
                                                </li>
                                            </g:each>
                                        </ul>
                                    </div>
                                </div>
                            </g:else>
                        </g:each>
                    </div>
                </g:each>
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
            <input type="hidden" name="patientId" value="${patientId}">
            <input type="hidden" name="emailStatus" value="${emailStatus}">

            <div class="task-done-panel">
                <input type="submit" name="submit" class="rc-btn task-done-btn" value="I'm Done">
            </div>
        </form>
    </div>
    </body>
    </html>

    <content tag="GA">
        <script>
            ga('send', 'event', '${taskTitle}', 'in progress', '${taskCode}');
        </script>
    </content>
</g:applyLayout>
