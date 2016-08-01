
<%@ page contentType="text/html;charset=UTF-8" %>
<g:set var="commonScriptPath" value="dist/commons.chunk.js"/>
<g:set var="cssPath" value="task/taskAlreadyComplete"/>
<g:set var="scriptPath" value="dist/taskAlreadyComplete.bundle.js"/>
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
            <div class="task-content">
                <div class="task-alreadyComplete">
                    <p class="text-complete">This questionnaire has already completed.</p>
                    <p class="text-complete">Click OK to go back to the task list.</p>
                </div>
                <form method="post">
                    <div class="task-done-panel">
                        <input type="hidden" name="code" value="${taskCode}"/>
                        <input type="hidden" name="taskId" value="${Task.taskId}"/>
                        <input type="hidden" name="taskType" value="${Task.type}"/>
                        <input type="hidden" name="baseToolType" value="${baseToolType}"/>

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

                        %{--<g:if test="${isInClinic}">--}%
                            %{--<input type="submit" class="rc-btn task-done-btn" value="OK"/>--}%
                        %{--</g:if>--}%
                        %{--<g:else>--}%
                            <a id="ok-link" href="/" class="rc-btn task-done-btn">OK</a>
                        %{--</g:else>--}%
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
