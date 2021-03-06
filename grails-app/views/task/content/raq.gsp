<%@ page import="com.ratchethealth.patient.RatchetConstants"%>
<g:set var="commonScriptPath" value="dist/commons.chunk.js"/>
<g:set var="scriptPath" value="dist/raqTool.bundle.js"/>
<g:set var="cssPath" value="task/raq"/>
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
        }

        .primary-color {
            color: ${ client.primaryColorHex?:'#0f137d' } !important;
        }

        .license-website {
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
    </head>

    <body>
        <div class="raq task-content">
        <div class="info container">${raw(Task.description)}</div>

        <form action="" method="post">
            <input type="hidden" name="code" value="${taskCode}"/>
            <input type="hidden" name="taskId" value="${Task.taskId}"/>
            <input type="hidden" name="taskType" value="${Task.type}"/>
            <input type="hidden" name="baseToolType" value="${baseToolType}"/>

            <div class="task-list-wrapper container">
                <g:each var="question" in="${Task.questions}" status="i">
                    <div class="question-list <g:if test="${errors && errors["${question.id}"]}">error</g:if>"
                         data-optional="${question.optional}">
                        <input type="hidden" name="optionals.${question.id}"
                               value="${question.optional ? '0' : '1'}"/>

                        <div class="question">
                            ${i + 1}: ${question.title}
                            <g:if test="${question.optional}">
                                <span class="optional-label">This question is optional.</span>
                            </g:if>
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

            <div class="care-partner container">
                <div class="care-head">
                    <p><strong>* What is a Care Partner?</strong></p>
                    <p>A Care Partner is a loved one, family, or friend who can help you after surgery. It is best if your care partner can</p>
                    <ul>
                        <li>• Come to your joint education class with you</li>
                        <li>• Come and visit you in the hospital to learn how to help you when you go home</li>
                        <li>• Attend one of your hospital therapy session after your surgery</li>
                        <li>• Be available to drive you home from the hospital when you are discharged</li>
                        <li>• Be a coach for you when you do your post-surgery exercises at home</li>
                        <li>• Help with general housekeeping</li>
                        <li>• Help you with meals, buy groceries, pick up medications</li>
                    </ul>
                </div>
                <div class="care-body">
                    <p>
                        Your Care Partner will not be doing any heavy lifting.
                        You will be able to walk, climb stairs, and get up and go to the bathroom when you leave the hospital.
                        They are there to provide support, both social and emotional, and help you have a sense of safety and security.
                        If you do not have a Care Partner, now is the time to start looking for one. You are making a big decision to have joint replacement surgery,
                        reach out to family, friends, or neighbours to help you through this journey.
                    </p>
                </div>
            </div>

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
