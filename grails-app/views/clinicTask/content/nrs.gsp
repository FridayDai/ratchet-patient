<g:set var="scriptPath" value="taskBundle"/>
<g:set var="cssPath" value="task/content/nrs"/>
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
            color: #ffffff;
        }
        </style>

        <script language="javascript" type="text/javascript">
            window.history.forward();
        </script>
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

        <form method="post">
            <input type="hidden" name="code" value="${taskCode}"/>
            <input type="hidden" name="taskType" value="${Task.type}"/>

            <div class="task-list-wrapper container">
                <g:each var="question" in="${Task.questions}" status="i">
                    <div class="question-list <g:if test="${errors && errors[i]}">error</g:if>">
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
                                <g:each var="j" in="${(0..<11)}">
                                    <li class="answer">
                                        <div class="text">
                                            ${j} -
                                            <g:if test="${j == 0}">No Pain</g:if>
                                            <g:if test="${j >= 1 && j < 4}">Mid Pain</g:if>
                                            <g:if test="${j >= 4 && j < 7}">Moderate Pain</g:if>
                                            <g:if test="${j >= 7 && j < 11}">Severe Pain</g:if>
                                        </div>
                                        <label class="choice choice-number choice-number-${j}">
                                            <input type="radio" class="rc-choice-hidden"
                                                <g:if test="${Task.type == 4}">
                                                    <g:if test="${i == 0}">name="choices.back"</g:if>
                                                    <g:if test="${i == 1}">name="choices.leg"</g:if>
                                                    <g:if test="${i == 0 && choices?.back == j}">checked</g:if>
                                                    <g:if test="${i == 1 && choices?.leg == j}">checked</g:if>
                                                </g:if>
                                                <g:if test="${Task.type == 5}">
                                                    <g:if test="${i == 0}">name="choices.neck"</g:if>
                                                    <g:if test="${i == 1}">name="choices.arm"</g:if>
                                                    <g:if test="${i == 0 && choices?.neck == j.toString()}">checked</g:if>
                                                    <g:if test="${i == 1 && choices?.arm == j.toString()}">checked</g:if>
                                                </g:if>
                                                   value="${j}"/>
                                            <span class="rc-radio"></span>
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

            <input type="hidden" name="clinicPathRoute" value="todoTask">
            <input hidden name="tasksList" value="${tasksList}">
            <input hidden name="treatmentCode" value="${treatmentCode}">

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
