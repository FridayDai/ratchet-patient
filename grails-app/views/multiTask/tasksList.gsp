<g:set var="cssPath" value="clinicTask/tasksList"/>
<g:set var="commonScriptPath" value="dist/commons.chunk.js"/>
<g:set var="scriptPath" value="dist/tasksList.bundle.js"/>
<g:applyLayout name="clientHeaderLayout">
    <html>
    <head>
        <style type="text/css">
        .primary-color {
            color: ${  client.primaryColorHex?:'#0f137d'  } !important;
        }

        .primary-border-color {
            border-color: ${  client.primaryColorHex?:'#0f137d'  } !important;
        }

        .primary-background-color {
            background-color: ${  client.primaryColorHex?:'#0f137d'  } !important;
        }

        .primary-hover-color:hover {
            color: #ffffff !important;
            background-color: ${  client.primaryColorHex?:'#0f137d'  } !important;
        }

        </style>

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
        <g:if test="${tasksList}">

            <div id="task-list-active">
                <g:render template="/multiTask/template/taskUL" model="[tasksList: tasksList, treatmentCode: treatmentCode, isInClinic: isInClinic]"/>
            </div>

            <div id="task-list-all" class="hide">
                <g:render template="/multiTask/template/taskUL" model="[allTasks: allTaskList, treatmentCode: treatmentCode, isInClinic:isInClinic]"/>
            </div>

            <form name="tasksListForm" method="post">
                <input type="hidden" name="tasksList" value="${tasksList}">
                <input type="hidden" name="itemIndex" value="${0}">
                <input type="hidden" name="treatmentCode" value="${treatmentCode}">
                <input type="hidden" name="patientId" value="${patientId}">
                <input type="hidden" name="emailStatus" value="${emailStatus}">


                <input type="hidden" name="pathRoute" value="tasksList">
                <input type="hidden" name="isInClinic" value="${isInClinic}">

                <div class="task-start-panel">
                    <input type="submit" class="rc-btn task-start-btn" value="Start All">
                    <div id="quick-filter-task" class="filter-link">
                        <span id="quick-filter-all">Show all tasks</span>
                        <span id="quick-filter-active" class="hide">Show active tasks only</span>
                    </div>
                </div>

            </form>
        </g:if>

        <g:elseif test="${tasksCompleted}">
            <div class="task-list-header">
                <div class="top-title">Congratulations!</div>

                <span>
                    You have completed
                    <g:if test="${tasksLength == 1}">
                        <strong>${tasksLength}</strong> task:
                    </g:if>
                    <g:else>
                        <strong>${tasksLength}</strong> tasks:
                    </g:else>
                </span>
            </div>

            <g:if test="${isSingleTask}">
            <div class="task-list-container">
                <span class="task-complete-list">
                    <p class="task-title-tip"><span class="task-done"></span><span class="task-index"></span>${taskTitle}</p>
                </span>
            </div>
            </g:if>

            <g:elseif test="${doneTaskList}">
            <div class="task-list-container">
                <span class="task-complete-list">

                    <g:each in="${doneTaskList}" var="${completeTask}" status="i">
                        <p class="task-title-tip"><span class="task-done"></span><span class="task-index"></span>${completeTask.title}</p>
                    </g:each>
                </span>
            </div>
                <form name="taskItemForm" method="post">

                    <input type="hidden" name="pathRoute" value="codeValidation">
                    <input type="hidden" name="treatmentCode" value="${treatmentCode}">
                    <input type="hidden" name="isInClinic" value="${isInClinic}">

                    <div class="task-start-panel">
                        <input type="submit" class="rc-btn task-start-btn" value="Ok">
                    </div>
                </form>
            </g:elseif>

        </g:elseif>

    </div>
    <g:render template="/shared/copyRight" />
    </body>
    </html>
</g:applyLayout>
