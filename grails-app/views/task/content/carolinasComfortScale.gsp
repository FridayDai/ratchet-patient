<%@ page import="com.ratchethealth.patient.RatchetConstants" %>
<g:set var="commonScriptPath" value="dist/commons.chunk.js"/>
<g:set var="scriptPath" value="dist/carolinasComfortScaleTool.bundle.js"/>
<g:set var="cssPath" value="task/carolinasComfortScale.css"/>
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
                color: ${  client.primaryColorHex?:'#0f137d'  } !important;
            }
        }

        .primary-color {
            color: ${  client.primaryColorHex?:'#0f137d'  } !important;
        }

        .license-website {
            color: ${  client.primaryColorHex?:'#0f137d'  } !important;
        }

        .primary-border-color {
            border-color: ${  client.primaryColorHex?:'#0f137d'  } !important;
        }

        .primary-background-color {
            background-color: ${  client.primaryColorHex?:'#0f137d'  } !important;
        }

        .task-done-btn {
            color: ${  client.primaryColorHex?:'#0f137d'  } !important;
            border-color: ${  client.primaryColorHex?:'#0f137d'  } !important;;
        }

        .task-done-btn:hover {
            color: #ffffff !important;
            background-color: ${  client.primaryColorHex?:'#0f137d'  } !important;
        }

        .rc-choice-hidden:checked + .rc-radio:before, .rc-radio:hover:before {
            background-color: ${  client.primaryColorHex?:'#0f137d'  } !important;
            width: 20px !important;
            height: 20px !important;
        }

        .task-done-btn[disabled], .task-done-btn[disabled]:hover {
            color: ${ client.primaryColorHex?:'#0f137d' } !important;
            background-color: #ffffff !important;
            cursor: default;
            opacity: 0.3;
        }
        </style>
    </head>

    <body>
    <div class="ccs task-content">

        <form action="" method="post">
            <input type="hidden" name="code" value="${taskCode}"/>
            <input type="hidden" name="taskId" value="${Task.taskId}"/>
            <input type="hidden" name="taskType" value="${Task.type}"/>
            <input type="hidden" name="baseToolType" value="${baseToolType}"/>

            <div class="task-list-wrapper container">

                <g:each var="section" in="${Task.sections}" status="j">

                    <div id="section-id-${section.id}" class="section-list" value="${section.id}">

                        <g:if test="${section.title}">
                            <div class="section-title"><b>${j+1}</b>. ${raw(section.title)}</div>
                        </g:if>

                        <g:each var="question" in="${section.questions}" status="i">
                            <div class="question-list <g:if test="${errors && errors["${question.id}"]}">error</g:if>"
                                 data-optional="${question.optional}">
                                <input type="hidden" name="optionals.${question.id}"
                                       value="${question.optional ? '0' : '1'}"/>
                                <g:hiddenField name="sections.${section.id}" value="${question.id}"/>

                                <div class="question">
                                    &#${i + 97};) ${question.title}
                                    <g:if test="${question.optional}">
                                        <span class="optional-label">This question is optional.</span>
                                    </g:if>
                                    <g:if test="${errors && errors["${question.id}"]}">
                                        <span class="error-label">This question is required.</span>
                                    </g:if>
                                </div>

                                <div class="answer-list">
                                    <ul class="list">
                                        <g:each var="choice" in="${question.choices}" status="k">
                                            <li class="answer">
                                                <div class="text">
                                                    <span class="choice-index">${k!= 6 ? k : 'N/A'}</span> ${choice.content}
                                                </div>
                                                <label class="choice">
                                                    <input type="radio"
                                                           class="rc-choice-hidden"
                                                           name="choices.${question.id}"
                                                           value="${choice.id}.${choice.sequence}"
                                                           <g:if test="${(choices && choices["${question.id}"]?.endsWith(choice.sequence)) ||
                                                                   choice.id == question.draftChoice}">checked</g:if>/>
                                                    <span class="rc-radio primary-radio-color"></span>
                                                </label>
                                            </li>
                                        </g:each>
                                    </ul>
                                </div>
                            </div>
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
            <input type="hidden" name="taskRoute" value="${taskRoute}">
            <input type="hidden" name="patientId" value="${patientId}">
            <input type="hidden" name="emailStatus" value="${emailStatus}">

            <div class="task-done-panel">
                <input type="submit" class="rc-btn task-done-btn" value="I'm Done">
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
