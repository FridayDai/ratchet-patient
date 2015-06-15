<g:set var="cssPath" value="task/result"/>
<g:set var="scriptPath" value="taskResultBundle"/>
<g:applyLayout name="taskLayout">
    <html>
    <head>
        <title>${Task.title}</title>

        <style type="text/css">
        @media only screen and (max-width: 767px) {
            .task-time {
                color: ${Task.color?:'#0f137d'} !important;
            }
        }

        .primary-color {
            color: ${Task.color?:'#0f137d'} !important;
        }

        .primary-border-color {
            color: ${Task.color?:'#0f137d'} !important;
        }

        .primary-background-color {
            color: ${Task.color?:'#0f137d'} !important;
        }
        </style>
    </head>

    <body>
    <div class="result-content">
        <div class="container clear">
            <div class="top">
                <div class="para1">COMPLETED!</div>

                <div class="para2">Thank you for completing the task.</div>

            </div>

            <div <g:if test="${session["completeTask.type"] == 4 || session["completeTask.type"] == 5}">class="middle nrs-width"</g:if>
                 <g:else>class="middle normal-width"</g:else>>

                <div class="report-header">Report</div>

                <div class="report-middle">
                    <g:if test="${session["completeTask.type"] == 4 || session["completeTask.type"]== 5}">
                        <g:if test="${session["completeTask.type"] == 4}">
                            <div class="score-header">Back Score</div>

                            <div class="score-header">Leg Score</div>
                        </g:if>
                        <g:else>
                            <div class="score-header">Neck Score</div>

                            <div class="score-header">Arm Score</div>
                        </g:else>

                        <div class="score-content">
                            <p class="inner-content content-header">Interpretaion:</p>

                            <p class="inner-content content-list">0 = no pain</p>

                            <p class="inner-content content-list">1-3 = mild pain(nagging,annoying,interfering,little with activities of daily living)</p>

                            <p class="inner-content content-list">4-6 =moderate pain (interferes significantly with activities of daily living)</p>

                            <p class="inner-content content-list">7-10 =severe pain(disabling;unable to perform activities of daily living)</p>
                        </div>
                    </g:if>
                    <g:else>
                        <div class="score-header">Score:${session["completeTask.score"]}</div>

                        <div class="score-content">
                            <p class="inner-content content-header">Interpretaion:</p>

                            <p class="inner-content content-list">0 = least disability</p>

                            <p class="inner-content content-list">100 = most disability</p>

                            <g:if test="${session["completeTask.type"] == 1 || session["completeTask.type"] == 6}">
                                <p class="inner-content content-list">10.1 = general population score</p>
                            </g:if>
                            <g:elseif test="${session["completeTask.type"] == 2}">
                                <p class="inner-content content-list">10.2 = general population score</p>
                            </g:elseif>
                            <g:else>
                                <p class="inner-content content-list">6.98 = general population score</p>
                            </g:else>

                        </div>
                    </g:else>

                %{--<g:if test="${completeTask.comparison}">--}%
                    <div class="report-bottom">
                        <p class="bottom-content">Comparison:</p>

                        %{--<p class="bottom-content">${completeTask.comparison} based on <g:formatDate--}%
                        %{--date="${completeTask.lastScoreTime}"--}%
                        %{--timeZone="${TimeZone.getTimeZone('America/Vancouver')}"--}%
                        %{--format="MMM d, yyyy"></g:formatDate> measurement</p>--}%
                    </div>
                    %{--</g:if>--}%
                </div>
            </div>

            <div class="bottom">
                <p>The result is securely stored for your care team to review.</p>

                %{--<p>Your next DASH measurement: May 26, 2015</p>--}%
            </div>
        </div>
    </div>
    </body>
    </html>
    <content tag="GA">
        <script>
            ga('send', 'event', '${taskTitle}', 'complete', '${taskCode}');
        </script>
    </content>
</g:applyLayout>
