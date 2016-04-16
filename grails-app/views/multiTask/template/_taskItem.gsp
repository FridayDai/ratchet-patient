<%@ page import="com.ratchethealth.patient.RatchetStatusCode" %>
<div class="task-item">
    <g:if test="${RatchetStatusCode.TASK_STATUS[task?.taskStatus] == 'complete'}">
        <div class="task-complete">
            <div class="item-left">
                <span><i class="fa fa-unlock" aria-hidden="true"></i>${task?.title}</span>

                <span class="task-date">
                    Aug 01, 2016
                    %{--<g:formatDate date="${task?.taskSendDate}" timeZone="${TimeZone.getTimeZone('America/Vancouver')}"--}%
                                  %{--format="MMM dd, yyyy"/>--}%
                </span>
            </div>

            <div class="item-right">
                <g:if test="${task.isBaseTool}">
                    <a class="btn">View</a>
                </g:if>
            </div>

        </div>
    </g:if>
    <g:elseif test="${RatchetStatusCode.TASK_STATUS[task?.taskStatus] == 'pending' || RatchetStatusCode.TASK_STATUS[task?.taskStatus] == 'overdue'}">
        <div class="task-active">
            <div class="item-left">
                <span><i class="fa fa-unlock" aria-hidden="true"></i>${task?.title}</span>

                <span class="task-date">
                    Aug 01, 2016
                    %{--<g:formatDate date="${task?.taskSendDate}" timeZone="${TimeZone.getTimeZone('America/Vancouver')}"--}%
                                  %{--format="MMM dd, yyyy"/>--}%
                </span>
            </div>

            <div class="item-right">
                <form name="taskItemForm" method="post">

                    <input type="hidden" name="pathRoute" value="tasksList">
                    <input type="hidden" name="taskRoute" value="pickTask">
                    <input type="hidden" name="treatmentCode" value="${treatmentCode}">
                    <input type="hidden" name="task" value="${task}">
                    <input type="hidden" name="isInClinic" value="${isInClinic}">

                    <div class="task-start-panel">
                        <input type="submit" class="rc-btn task-start-btn" value="Start">
                    </div>
                </form>
            </div>
        </div>


    </g:elseif>
    <g:else>
        <div class="task-schedule">
            <div class="item-left">
                <span><i class="fa fa-unlock" aria-hidden="true"></i>${task?.title}</span>

                <span class="task-date">
                    Aug 01, 2016
                    %{--<g:formatDate date="${task?.taskSendDate}" timeZone="${TimeZone.getTimeZone('America/Vancouver')}"--}%
                                  %{--format="MMM dd, yyyy"/>--}%
                </span>
            </div>

            <div class="item-right">
            </div>
        </div>
    </g:else>

</div>
