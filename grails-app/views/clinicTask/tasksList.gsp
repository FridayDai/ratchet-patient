<g:set var="cssPath" value="clinicTask/tasksList"/>
<g:applyLayout name="main">
    <html>
    <head>
        <style type="text/css">
        .primary-color {
            color: ${     client.primaryColorHex?:'#0f137d'     } !important;
        }

        .primary-border-color {
            border-color: ${     client.primaryColorHex?:'#0f137d'     } !important;
        }

        .primary-background-color {
            background-color: ${     client.primaryColorHex?:'#0f137d'     } !important;
        }

        .primary-hover-color:hover {
            color: #ffffff !important;
            background-color: ${     client.primaryColorHex?:'#0f137d'     } !important;
        }

        .task-start-btn {
            color: ${     client.primaryColorHex?:'#0f137d'     } !important;
            border-color: ${     client.primaryColorHex?:'#0f137d'     } !important;;
        }

        .task-start-btn:hover {
            color: #ffffff !important;
            background-color: ${     client.primaryColorHex?:'#0f137d'     } !important;
        }
        </style>

        <script language="javascript" type="text/javascript">
            window.history.forward();
        </script>
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
        </span>
    </div>

    <div class="main-container">
        <g:if test="${tasksList}">
            <div class="task-list-header">
                <P>Hi ${patientFirstName},</P>

                <p>You have <strong>${tasksLength}</strong> tasks:</p>
            </div>

            <g:each in="${tasksList}" var="${task}">

                <div class="task-title primary-background-color">
                    <div class="task-done-or-not"></div>
                    ${task.title}
                </div>
            </g:each>

            <form name="tasksListForm" method="post">
                <input hidden name="tasksList" value="${tasksList}">
                <input hidden name="itemIndex" value="${0}">
                <input hidden name="treatmentCode" value="${treatmentCode}">

                <input type="hidden" name="clinicPathRoute" value="tasksList">
                <div class="task-start-panel">
                    <input type="submit" class="rc-btn task-start-btn" value="Start">
                </div>

            </form>
        </g:if>

        <g:elseif test="${completeTasksList}">
            <div class="task-list-header">
                <P>Hi ${completeTasksList.firstName},</P>

                <p>You have completed <strong>${tasksLength}</strong> task(s):</p>
            </div>

            <g:each in="${doneTaskList}" var="${completeTask}">

                <div class="task-title primary-background-color">
                    <div class="task-done-or-not task-done"></div>
                    ${completeTask.title}
                </div>
            </g:each>

            <g:if test="${uncompleteTasksList}">
                <g:each in="${uncompleteTasksList}" var="${uncompleteTask}">

                    <div class="task-title primary-background-color">
                        <div class="task-done-or-not"></div>
                        ${uncompleteTask.title}
                    </div>
                </g:each>
            </g:if>

            <form name="completeTaskListForm" method="post">

                <div class="task-start-panel">
                    <g:actionSubmit value="Ok" controller="clinicTestPath" action="index"
                                    class="rc-btn task-start-btn"/>
                </div>
            </form>
        </g:elseif>

        <g:else>
            <div class="task-list-header">
                <P>Hi ${patientFirstName},</P>

                <p>You have <strong>0</strong> task</p>
            </div>

            <form name="noTaskListForm" method="post">

                <div class="task-start-panel">
                    <g:actionSubmit value="Ok" controller="clinicTestPath" action="index"
                                    class="rc-btn task-start-btn"/>
                </div>
            </form>
        </g:else>

    </div>

    </body>
    </html>
</g:applyLayout>
