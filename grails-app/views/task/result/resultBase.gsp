<g:set var="cssPath" value="task/result"/>
<g:set var="scriptPath" value="taskResultBundle"/>
<g:set var="noTips" value="true"/>
<g:set var="hasAssistMe" value="true"/>

<g:applyLayout name="taskLayout">
    <html>
    <head>
        <title>${Task.title}</title>

        <style type="text/css">
        @media only screen and (max-width: 767px) {
            .task-time {
                color: ${ Task.color?:'#0f137d' } !important;
            }
        }

        .primary-color {
            color: ${ Task.color?:'#0f137d' } !important;
        }

        .primary-border-color {
            color: ${ Task.color?:'#0f137d' } !important;
        }

        .primary-background-color {
            color: ${ Task.color?:'#0f137d' } !important;
        }
        </style>
    </head>

    <body>
    <div class="result-content" id="result-content">
        <div class="container clear">
            <div class="top">
                <div class="para1">COMPLETED!</div>

                <div class="para2">Thank you for completing the task.</div>

            </div>

            <g:if test="${completeTask.type < 9}">
            <div <g:if test="${completeTask.type == 4 || completeTask.type == 5}">class="middle nrs-width"</g:if>
                 <g:elseif
                         test="${(completeTask.type == 1 || completeTask.type == 2 || completeTask.type == 3 || completeTask.type == 6) && completeTask.comparison}">class="middle compare-width"</g:elseif>
                 <g:else>class="middle normal-width"</g:else>>

                <div class="report-header">Report</div>

                <div class="report-middle">
                    <g:if test="${completeTask.type == 4 || completeTask.type == 5}">
                        <g:render template="result/nrsResult" model="['completeTask': completeTask]"/>
                    </g:if>
                    <g:elseif test="${completeTask.type == 7 || completeTask.type == 8}">
                        <g:render template="result/koosResult" model="['completeTask': completeTask]"/>
                    </g:elseif>
                    <g:else>
                        <g:render template="result/taskResult" model="['completeTask': completeTask]"/>
                    </g:else>
                </div>
            </div>

            <div class="bottom">
                <p>The result is securely stored for your care team to review.</p>
            </div>
            </g:if>
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
