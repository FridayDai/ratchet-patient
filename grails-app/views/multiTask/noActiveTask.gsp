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
        <g:if test="${allTaskList}">

            <div id="task-list-active">
                <div class="no-task-list">
                    <i class="fa fa-flag-checkered" aria-hidden="true"></i>
                    <div>There’s no active tasks</div>
                </div>
            </div>

            <div id="task-list-all" class="hide">
                <g:render template="/multiTask/template/taskUL"
                          model="[allTasks: allTaskList, treatmentCode: treatmentCode, isInClinic: isInClinic]"/>
            </div>

            <div class="task-start-panel">
                <div id="quick-filter-task" class="filter-link">
                    <span id="quick-filter-all">Show completed and future tasks</span>
                    <span id="quick-filter-active" class="hide">Show active tasks only</span>
                </div>
            </div>

        </g:if>
    </div>
    <g:render template="/shared/copyRight"/>
    </body>
    </html>
</g:applyLayout>
