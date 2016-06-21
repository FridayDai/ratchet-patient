<%@ page import="com.ratchethealth.patient.RatchetConstants" %>
<g:set var="commonScriptPath" value="dist/commons.chunk.js"/>
<g:set var="scriptPath" value="dist/followUpTool.bundle.js"/>
<g:set var="cssPath" value="task/followUp"/>
<g:if test="${!isInClinic}">
    <g:set var="hasAssistMe" value="true"/>
</g:if>
<g:applyLayout name="taskContent">
    <html>
    <head>
        <title>${Task.title}</title>

        <style type="text/css">

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

        .rc-choice-hidden:checked + .rc-checkbox {
            background-color: ${     client.primaryColorHex?:'#0f137d'     };
        }

        .task-done-btn[disabled], .task-done-btn[disabled]:hover {
            color: ${ client.primaryColorHex?:'#0f137d' } !important;
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
    <div class="follow-up task-content">
        <form action="" method="post" data-draft="${Draft}">
            <input type="hidden" name="code" value="${taskCode}"/>
            <input type="hidden" name="taskId" value="${Task.taskId}"/>
            <input type="hidden" name="taskType" value="0"/>
            <input type="hidden" name="baseToolType" value="${baseToolType}"/>

            <div class="task-list-wrapper container">
                <div class="question-list">

                    <div class="question">
                       <strong>
                           We hope you are doing well after your recent spine surgery.
                           If there is anything we can do to assist in your care, please write them below:
                       </strong>
                    </div>

                    <div class="answer-list">
                        <ul class="list">
                            <li class="answer">
                                <span id="assistance-choice" class="inline">
                                    <span class="text">
                                        No immediate assistance required.</span>
                                    <label class="choice">
                                        <input id="assistance-toggle-hide" type="hidden" name="choices.assistance"
                                               class="checkbox-choice-hidden" value="true">
                                        <input id="assistance-toggle" type="checkbox"
                                               class="rc-choice-hidden"
                                            <g:if test="${Draft && Draft['assistance'] == 'false'}"> checked</g:if>
                                        />
                                        <span class="rc-checkbox pain-toggle"></span>
                                    </label>
                                </span>
                            </li>
                        </ul>

                        <div class="textarea-container">
                            <textarea placeholder="Your comments here..." maxlength="5000" name="choices.content">${Draft?.content}</textarea>
                        </div>
                    </div>
                </div>
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
            <input type="hidden" name="hardcodeTask" value="true">

            <div class="task-done-panel">
                <input type="submit" class="rc-btn task-done-btn" value="I'm Done">
            </div>
        </form>

        <div class="task-copyright text-center">
            <span>&#169 Institute for Work & Health 2006.</span>
            <span class="inline-right">All rights reserved.</span>
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
