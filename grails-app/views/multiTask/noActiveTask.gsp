<g:set var="cssPath" value="clinicTask/tasksList"/>
<g:set var="commonScriptPath" value="dist/commons.chunk.js"/>
<g:set var="scriptPath" value="dist/tasksList.bundle.js"/>
<g:applyLayout name="clientHeaderLayout">
    <html>
    <head>
        <g:if test="${isInClinic}">
            <script language="javascript" type="text/javascript">
                window.history.forward();
            </script>
        </g:if>

        <g:if test="${isSingleTask}">
            <script language="javascript" type="text/javascript">
                (function(){
                    window.opener=null;
                    window.open('','_self');
                    window.setTimeout("window.close()",4000);
                })();
            </script>
        </g:if>

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
    </head>

    <body>

    <div class="main container">
        <g:if test="${!isInClinic && !allTaskList}">
            <p class="only-message">Welcome! You have 0 tasks.</p>
        </g:if>
        <g:if test="${isInClinic}">
            <p class="only-message">Welcome! You have 0 tasks.</p>

            <form name="taskItemForm">
                <div class="task-start-panel">
                    <input type="submit" class="rc-btn task-start-btn" value="Ok">
                </div>
            </form>
        </g:if>
        <g:elseif test="${allTaskList}">

            <div id="task-list-active">
                <div class="no-task-list">
                    <i class="fa fa-flag-checkered" aria-hidden="true"></i>
                    <div>All tasks completed</div>
                </div>
            </div>

            <div id="task-list-all" class="hide">
                <g:render template="/multiTask/template/taskUL"
                          model="[allTasks: allTaskList, treatmentCode: treatmentCode, isInClinic: isInClinic]"/>
            </div>

            <div class="task-start-panel">
                <div id="quick-filter-task" class="filter-link">
                    <span id="quick-filter-all">Show all tasks</span>
                    <span id="quick-filter-active" class="hide">Show active tasks only</span>
                </div>
            </div>

        </g:elseif>
    </div>
    <g:render template="/shared/copyRight"/>
    </body>
    </html>
</g:applyLayout>
