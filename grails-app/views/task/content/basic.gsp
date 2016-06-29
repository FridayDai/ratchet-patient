<%@ page import="com.ratchethealth.patient.RatchetConstants"%>
<g:set var="commonScriptPath" value="dist/commons.chunk.js"/>
<g:set var="scriptPath" value="dist/basicTool.bundle.js"/>
<g:set var="cssPath" value="task/basic"/>
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

            .task-content .question {
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
    <div class="basic task-content">
        <form action="" method="post">
            <input type="hidden" name="code" value="${taskCode}"/>
            <input type="hidden" name="taskId" value="${Task.taskId}"/>
            <input type="hidden" name="taskType" value="0"/>
            <input type="hidden" name="baseToolType" value="${baseToolType}"/>

            <div class="basic-markdown-content"><markdown:renderHtml>${raw(Task.description)}</markdown:renderHtml></div>

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
                <g:if test="${!alreadyComplete}">
                    <input type="submit" class="rc-btn task-done-btn" value="I'm Done">
                </g:if>
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
