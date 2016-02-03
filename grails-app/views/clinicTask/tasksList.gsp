<g:set var="cssPath" value="clinicTask/tasksList"/>
<g:applyLayout name="main">
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
    </head>

    <body>
    <div class="main-header primary-border-color clear">
        <a class="nav-info" href="/">
            <img src="${client.logo}" alt="" class="client-logo primary-border-color"/>

            <p class="primary-color">${client.portalName}</p>
        </a>
        <span class="copy-right">
            <span class="distance">Powered By</span>
            <img class="logo" src="${assetPath(src: 'Ratchet_Logo_grey.png')}"/>
            <span class="rc-version">V. RH0.1</span>
        </span>
    </div>

    <div class="main-container">
        <g:if test="${tasksList}">
            <div class="task-list-header">
                <span>Welcome ${patientFirstName}!</span>

                <span>
                    You have
                    <g:if test="${tasksLength == 1}">
                        <strong>${tasksLength}</strong> task
                    </g:if>
                    <g:else>
                        <strong>${tasksLength}</strong> tasks
                    </g:else>
                    to complete. Click <span class="task-start-font">Start!</span> to begin.
                </span>
            </div>

            <div class="task-list-container">
            <g:each in="${tasksList}" var="${task}" status="i">
                    <p class="task-title-tip"><span class="task-index">${i+1}.</span>${task.title}</p>
            </g:each>
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
                    <span class="arrow-tip"></span>
                    <input type="submit" class="rc-btn task-start-btn" value="Start !">
                </div>

            </form>
        </g:if>

        <g:elseif test="${tasksCompleted}">
            <div class="task-list-header">
                <span>Congratulations!</span>

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
                <p class="task-title-tip"><span class="task-done"></span><span class="task-index"></span>${taskTitle}</p>
            </div>
            </g:if>

            <g:elseif test="${doneTaskList}">
            <div class="task-list-container">
                <g:each in="${doneTaskList}" var="${completeTask}" status="i">
                    <p class="task-title-tip"><span class="task-done"></span><span class="task-index">${i+1}.</span>${completeTask.title}</p>
                </g:each>
            </div>
            </g:elseif>

            <g:elseif test="${uncompleteTasksList}">
                <div class="task-list-container">
                    <g:each in="${uncompleteTasksList}" var="${uncompleteTasksList}" status="i">
                        <p class="task-title-tip"><span class="task-index">${i+1}.</span>${uncompleteTasksList.title}</p>
                    </g:each>
                </div>
            </g:elseif>
        </g:elseif>

        <g:else>
            <div class="task-list-header">
                <P>Hi ${patientFirstName},</P>

                <p>You have <strong>0</strong> tasks</p>
            </div>
        </g:else>
    </div>
    <g:render template="/shared/taskFooter"/>
    </body>
    </html>
</g:applyLayout>
