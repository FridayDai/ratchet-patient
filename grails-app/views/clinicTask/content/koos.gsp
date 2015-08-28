<g:set var="scriptPath" value="taskBundle"/>
<g:set var="cssPath" value="task/content/koos"/>
<g:applyLayout name="taskLayout">
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
        </style>

        <script language="javascript" type="text/javascript">
            window.history.forward();
        </script>
    </head>

    <body>
    <div class="koos task-content">
        <div class="info container">${raw(Task.description)}</div>

        <form method="post">
            <input type="hidden" name="code" value="${taskCode}"/>
            <input type="hidden" name="taskType" value="${Task.type}"/>

            <div class="task-list-wrapper container">
                <% def secondTitle = "" %>
                <g:each var="section" in="${Task.sections}" status="i">
                    <div class="section-list" value="${section.id}">
                        <g:if test="${i == 0}">
                            <% def splitTitle %>
                            <% splitTitle = section.title.split(/\(#\)/) %>
                            <% if (splitTitle.size() >= 2) { %>
                            <% secondTitle = splitTitle[1]
                            } %>
                            <div class="section-title">${raw(splitTitle[0])}</div>
                        </g:if>
                        <g:else>
                            <div class="section-title">${raw(section.title)}</div>
                        </g:else>

                        <g:each var="question" in="${section.questions}" status="j">

                            <g:if test="${Task.type == 7 && i == 0 && j == 5}">
                                <div class="section-title">${raw(secondTitle)}</div>
                            </g:if>
                            <g:elseif test="${Task.type == 8 && i == 0 && j == 3}">
                                <div class="section-title">${raw(secondTitle)}</div>
                            </g:elseif>

                            <div class="question-list <g:if test="${errors && errors["${question.id}"]}">error</g:if>">
                                <input type="hidden" name="optionals.${question.id}"
                                       value="${question.optional ? '0' : '1'}"/>

                                <div class="question">
                                    ${question.order}. ${question.title}
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
                                                           <g:if test="${choices && choices["${question.id}"]?.endsWith(choice.sequence)}">checked</g:if>/>
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

            <g:if test="${(itemIndex + 1) < tasksLength}">
                <input hidden name="itemIndex" value="${itemIndex + 1}">
            </g:if>
            <g:else>
                <input hidden name="itemIndex" value="${tasksLength}">
            </g:else>

            <input hidden name="tasksList" value="${tasksList}">
            <input hidden name="treatmentCode" value="${treatmentCode}">
            <input type="hidden" name="clinicPathRoute" value="todoTask">

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
