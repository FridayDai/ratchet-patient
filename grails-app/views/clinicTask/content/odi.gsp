<g:set var="scriptPath" value="taskBundle"/>
<g:set var="cssPath" value="task/content/odi"/>
<g:applyLayout name="taskLayout">
    <html>
    <head>
        <title>${Task.title}</title>

        <style type="text/css">
        @media only screen and (max-width: 767px) {
            .task-time {
                color: ${client.primaryColorHex?:'#0f137d'} !important;
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
            border-color: ${client.primaryColorHex?:'#0f137d'} !important;;
        }

        .task-done-btn:hover {
            color: #ffffff !important;
            background-color: ${client.primaryColorHex?:'#0f137d'} !important;
        }

        .rc-choice-hidden:checked + .rc-radio:before, .rc-radio:hover:before {
            background-color: ${client.primaryColorHex?:'#0f137d'} !important;
        }
        </style>

        <script language="javascript" type="text/javascript">
            window.history.forward();
        </script>
    </head>

    <body>
    <div class="odi task-content">
        <div class="info container">${raw(Task.description)}</div>

        <g:form uri="/in_clinic" name="odiTaskForm" method="post">
            <input type="hidden" name="code" value="${taskCode}"/>
            <input type="hidden" name="taskType" value="${Task.type}"/>

            <div class="task-list-wrapper container">
                <g:each var="question" in="${Task.questions}" status="i">
                    <div class="question-list <g:if test="${errors && errors["${question.id}"]}">error</g:if>"
                         data-optional="${question.optional}">
                        <input type="hidden" name="optionals.${question.id}"
                               value="${question.optional ? '0' : '1'}"/>

                        <div class="question primary-color">
                            Section ${i + 1}: ${question.title}
                            <g:if test="${errors && errors["${question.id}"]}">
                                <span class="error-label">This question is required.</span>
                            </g:if>
                        </div>

                        <div class="answer-list">
                            <ul class="list">
                                <g:each var="choice" in="${question.choices}">
                                    <li class="answer">
                                        <div class="text">${choice.content}</div>
                                        <label class="choice">
                                            <input type="radio"
                                                   class="rc-choice-hidden"
                                                   name="choices.${question.id}"
                                                   value="${choice.id}.${choice.sequence}"
                                                   <g:if test="${choices && choices["${question.id}"]?.endsWith(choice.sequence)}">checked</g:if>/>
                                            <span class="rc-radio primary-radio-color"></span>
                                        </label>
                                    </li>
                                </g:each>
                            </ul>
                        </div>
                    </div>
                </g:each>
            </div>

            <g:if test="${(itemIndex + 1) < tasksLength}">
                <input hidden name="itemIndex" value="${itemIndex + 1}">
            </g:if>
            <g:else>
                <input hidden name="itemIndex" value="${tasksLength}">
            </g:else>

            <input hidden name="tasksList" value="${tasksList}">
            <input hidden name="treatmentCode" value="${treatmentCode}">
            <div class="task-done-panel">
                <g:actionSubmit value="I'm Done" action="submitTasks" class="rc-btn task-done-btn"/>
            </div>
        </g:form>

        <g:if test="${Task.type == 2}">
            <div class="task-copyright text-center">
                <span>ODI © Jeremy Fairbank, 1980.</span>
                <span class="inline-right">All Rights Reserved.</span>
            </div>
        </g:if>

    </div>
    </body>
    </html>
    <content tag="GA">
        <script>
            ga('send', 'event', '${taskTitle}', 'in progress', '${taskCode}');
        </script>
    </content>
</g:applyLayout>