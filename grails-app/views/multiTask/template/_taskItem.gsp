<%@ page import="com.ratchethealth.patient.RatchetStatusCode" %>

<g:if test="${RatchetStatusCode.TASK_STATUS[task?.taskStatus] == 'complete'}">
    <div class="task-item clear task-complete">
        <div class="item-left">
            <span>
                <i class="fa fa-check" aria-hidden="true"></i>
                <span class="task-title">${task?.title}</span>
            </span>

            <span class="task-date">
                <g:formatDate date="${task?.taskSendDate}" timeZone="${TimeZone.getTimeZone('America/Vancouver')}"
                format="MMM dd, yyyy"/>
            </span>
        </div>

        <div class="item-right">
            <g:if test="${task?.isBasicTool}">
                <div class="btn-panel">
                    %{--<a class="rc-btn task-view-btn" target="_blank" href="${task?.code}?pathRoute=tasksList">View</a>--}%
                    <form name="taskItemForm" method="post" target="_blank">

                        <input type="hidden" name="pathRoute" value="tasksList">
                        <input type="hidden" name="taskRoute" value="pickTask">
                        <input type="hidden" name="treatmentCode" value="${treatmentCode}">
                        <input type="hidden" name="task" value="${task}">
                        <input type="hidden" name="isInClinic" value="${isInClinic}">

                        <div class="btn-panel">
                            <input type="submit" class="rc-btn task-view-btn" target="_blank" value="view">
                        </div>
                    </form>
                </div>
            </g:if>
        </div>

    </div>
</g:if>
<g:elseif
        test="${RatchetStatusCode.TASK_STATUS[task?.taskStatus] == 'pending' || RatchetStatusCode.TASK_STATUS[task?.taskStatus] == 'overdue'}">
    <div class="task-item clear task-active">
        <div class="item-left">
            <span>
                <i class="fa fa-unlock" aria-hidden="true"></i>
                <span class="task-title">${task?.title}</span>
            </span>

            <span class="task-date">
                <g:formatDate date="${task?.taskSendDate}" timeZone="${TimeZone.getTimeZone('America/Vancouver')}"
                format="MMM dd, yyyy"/>
            </span>
        </div>

        <div class="item-right">
            <form name="taskItemForm" method="post">

                <input type="hidden" name="pathRoute" value="tasksList">
                <input type="hidden" name="taskRoute" value="pickTask">
                <input type="hidden" name="treatmentCode" value="${treatmentCode}">
                <input type="hidden" name="task" value="${task}">
                <input type="hidden" name="isInClinic" value="${isInClinic}">

                <div class="btn-panel">
                    <input type="submit" class="rc-btn task-start-btn" value="Start">
                </div>
            </form>
        </div>
    </div>

</g:elseif>
<g:else>
    <div class="task-item  clear task-schedule">
        <div class="item-left">
            <span>
                <i class="fa fa-lock" aria-hidden="true"></i>
                <span class="task-title">${task?.title}</span>
            </span>

            <span class="task-date">
                <g:formatDate date="${task?.taskSendDate}" timeZone="${TimeZone.getTimeZone('America/Vancouver')}"
                format="MMM dd, yyyy"/>
            </span>
        </div>

        <div class="item-right">
        </div>
    </div>
</g:else>


