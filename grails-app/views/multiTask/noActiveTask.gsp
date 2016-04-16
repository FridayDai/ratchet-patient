<g:set var="cssPath" value="clinicTask/tasksList"/>
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

            <div id="task-list-all" class="hide">
                <g:render template="/multiTask/template/taskUL"
                          model="[allTasks: allTaskList, treatmentCode: treatmentCode, isInClinic: isInClinic]"/>
            </div>

            <div class="task-start-panel">
                <div id="quick-filter-task">
                    <span id="quick-filter-active">Show completed and future tasks</span>
                    <span id="quick-filter-all" class="hide">Show active tasks only</span>
                </div>
            </div>

        </g:if>
    </div>
    <g:render template="/shared/copyRight"/>
    </body>
    </html>
</g:applyLayout>
