<%@ page import="com.ratchethealth.patient.RatchetConstants"%>
<%@ page import="com.ratchethealth.patient.RatchetStatusCode" %>
<g:set var="commonScriptPath" value="dist/commons.chunk.js"/>
<g:if test="${Task.type == 15 || Task.type == 1000}">
    <g:set var="scriptPath" value="dist/koosJRLikeTool.bundle.js"/>
</g:if>
<g:else>
    <g:set var="scriptPath" value="dist/koosLikeTool.bundle.js"/>
</g:else>
<g:set var="cssPath" value="task/koos"/>
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
    <div class="koos task-content">
        <div class="info container">${raw(Task.description)}</div>

        <form id="koos" name="koos" method="post">
            <input type="hidden" name="code" value="${taskCode}"/>
            <input type="hidden" name="taskId" value="${Task.taskId}"/>
            <input type="hidden" name="taskType" value="${Task.type}"/>

            <div class="task-list-wrapper container">
                <% def firstTitle = "" %>
                <% def secondTitle = "" %>
                <g:each var="section" in="${Task.sections}" status="i">

                    <div id="section-id-${section.id}" class="section-list" value="${section.id}">

                        <g:if test="${Task.type != 15 && Task.type != 1000 && (section.title.startsWith("<h3>Symptoms") || section.title.startsWith("<h3>Pain"))}">
                            <% def splitTitle%>
                            <% splitTitle = section.title.split(/\(#\)/) %>
                            <% if (splitTitle.size() >= 2) { %>
                            <% firstTitle = splitTitle[0] %>
                            <% secondTitle = splitTitle[1]
                            } %>
                            <div class="section-title">${raw(firstTitle)}</div>
                        </g:if>
                        <g:else>
                            <div class="section-title">${raw(section.title)}</div>
                        </g:else>

                        <g:each var="question" in="${section.questions}" status="j">

                            <g:if test="${secondTitle && firstTitle && firstTitle.startsWith("<h3>Symptoms")}">
                                <g:if test="${Task.type == RatchetConstants.ToolEnum.KOOS.value && j == 5}">
                                    <div class="section-title">${raw(secondTitle)}</div>
                                </g:if>
                                <g:elseif test="${Task.type == RatchetConstants.ToolEnum.HOOS.value && j == 3}">
                                    <div class="section-title">${raw(secondTitle)}</div>
                                </g:elseif>
                            </g:if>

                            <g:elseif test="${secondTitle && firstTitle && firstTitle.startsWith("<h3>Pain") && j == 1 }">
                                    <div class="section-title">${raw(secondTitle)}</div>
                            </g:elseif>


                            <div class="question-list <g:if test="${errors && errors["${question.id}"]}">error</g:if>">
                                <input type="hidden" name="optionals.${question.id}"
                                       value="${question.optional ? '0' : '1'}"/>

                                <div class="question">
                                    ${question.order}. ${raw(question.title)}
                                    <g:if test="${errors && errors["${question.id}"]}">
                                        <span class="error-label">This question is required.</span>
                                    </g:if>
                                </div>

                                <g:hiddenField name="sections.${section.id}" value="${question.id}"></g:hiddenField>

                                <div class="answer-list answer-list-${question.order}">
                                    <ul class="list horizontal-list">
                                        <g:each var="choice" in="${question.choices}">
                                            <li class="answer">
                                                <div class="text">${choice.content}</div>
                                                <label class="choice">
                                                    <input type="radio" class="rc-choice-hidden"
                                                           name="choices.${question.id}"
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
