<%@ page import="com.ratchethealth.patient.RatchetConstants"%>
<g:set var="commonScriptPath" value="dist/commons.chunk.js"/>
<g:set var="scriptPath" value="dist/nrsGeneralTool.bundle.js"/>
<g:set var="cssPath" value="task/nrs"/>
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
                color: ${client.primaryColorHex?:'#0f137d'} !important;
            }

            .assist-bottom {
                display: none;
            }
        }

        .primary-color {
            color: ${client.primaryColorHex?:'#0f137d'} !important;
        }

        .primary-border-color {
            border-color: ${client.primaryColorHex?:'#0f137d'} !important;
        }

        .primary-background-color {
            background-color: ${client.primaryColorHex?:'#0f137d'} !important;
        }

        .task-done-btn {
            color: ${client.primaryColorHex?:'#0f137d'} !important;
            border-color: ${client.primaryColorHex?:'#0f137d'} !important;
        }

        .task-done-btn:hover {
            color: #ffffff !important;
            background-color: ${client.primaryColorHex?:'#0f137d'} !important;
        }

        .rc-choice-hidden:checked + .rc-radio:before {
            background-color: ${client.primaryColorHex?:'#0f137d'} !important;
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
    <div class="nrs task-content">
        <div class="info container">${Task.description}</div>

        <div class="description">
            <p>0 = No Pain</p>

            <p>1-3 = Mild Pain (nagging, annoying, interfering little with activities of daily living)</p>

            <p>4-6 = Moderate Pain (interferes significantly with activities of daily living)</p>

            <p>7-10 = Severe Pain (disabling; unable to perform activities of daily living)</p>
        </div>

        <form id="nrs" name="nrs" method="post" data-draft="${Draft}">
            <input type="hidden" name="code" value="${taskCode}"/>
            <input type="hidden" name="taskId" value="${Task.taskId}"/>
            <input type="hidden" name="taskType" value="${Task.type}"/>
            <input type="hidden" name="baseToolType" value="${baseToolType}"/>

            <div class="task-list-wrapper container">
                <g:each var="question" in="${Task.questions}" status="i">
                    <div class="question-list <g:if test="${errors && errors[i]}">error</g:if>" data-index="${i}">
                        <div class="question primary-color">
                            ${raw(question.title)}
                            <g:if test="${errors && errors[i]}">
                                <span class="error-label">This question is required.</span>
                            </g:if>
                        </div>

                            <div class="answer-list">
                                <div class="answer-description">
                                    <span class="no-pain">No Pain</span>
                                    <span class="severe-pain">Severe Pain</span>
                                </div>
                                <ul class="list">
                                    <g:each var="choice" in="${question.choices}">
                                        <li class="answer">
                                            <div class="text">
                                                ${choice.content} -
                                                <g:if test="${choice.content == '0'}">No Pain</g:if>
                                                <g:if test="${choice.content == '1' ||
                                                                choice.content == '2' ||
                                                                    choice.content == '3'}">Mid Pain</g:if>
                                                <g:if test="${choice.content == '4' ||
                                                                choice.content == '5' ||
                                                                    choice.content == '6'}">Moderate Pain</g:if>
                                                <g:if test="${choice.content == '7' ||
                                                                choice.content == '8' ||
                                                                    choice.content == '9' ||
                                                                        choice.content == '10'}">Severe Pain</g:if>
                                            </div>
                                            <label class="choice choice-number choice-number-${choice.content}">
                                                <input type="radio"
                                                       class="rc-choice-hidden"
                                                       name="choices.${question.id}"
                                                       value="${choice.id}.${choice.sequence}"
                                                       <g:if test="${(choices && choices["${question.id}"]?.endsWith(choice.sequence)) ||
                                                               choice.id == question.draftChoice}">checked</g:if>/>
                                                <span class="rc-radio"></span>
                                            </label>
                                        </li>
                                    </g:each>
                                </ul>
                            </div>
                    </div>
                </g:each>
            </div>

            <g:if test="${itemIndex != null && (itemIndex + 1) < tasksLength}">
                <input type="hidden" name="itemIndex" value="${itemIndex + 1}">
            </g:if>
            <g:else>
                <input type="hidden" name="itemIndex" value="${tasksLength}">
            </g:else>

            <input type="hidden" name="pathRoute" value="todoTask">
            <input type="hidden" name="taskRoute" value="${taskRoute}">
            <input type="hidden" name="tasksList" value="${tasksList}">
            <input type="hidden" name="treatmentCode" value="${treatmentCode}">
            <input type="hidden" name="isInClinic" value="${isInClinic}">
            <input type="hidden" name="patientId" value="${patientId}">
            <input type="hidden" name="emailStatus" value="${emailStatus}">

            <div class="task-done-panel">
                <input type="submit" class="rc-btn task-done-btn" value="I'm Done"/>
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
