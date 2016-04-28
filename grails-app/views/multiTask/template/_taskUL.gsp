<div class="list-container">

    <g:if test="${allTasks}">
        <div>
            <g:each in="${allTasks}" var="task" status="i">
                <g:render template="/multiTask/template/taskItem" model="[task: task, treatmentCode: treatmentCode, isInClinic: isInClinic]"/>
            </g:each>

            <div class="more-text">And More...</div>
        </div>
    </g:if>
    <g:else>
        <div>
            <div class="top-line"></div>

            <g:each in="${tasksList}" var="task" status="i">
                <g:render template="/multiTask/template/taskItem" model="[task: task, treatmentCode: treatmentCode, isInClinic: isInClinic]"/>
            </g:each>

        </div>
    </g:else>

</div>

