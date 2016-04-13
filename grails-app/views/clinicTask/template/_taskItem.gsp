<div class="task-item">
    <g:if test="${status == 'complete'}">
        <div class="task-complete">
            <div class="item-left">
                <span><i class="fa fa-unlock" aria-hidden="true"></i> PROMIS 10</span>

                <span class="task-date">Aug 15, 2016</span>
            </div>

            <div class="item-right">
                <button class="btn">View</button>
            </div>

        </div>
    </g:if>
    <g:elseif test="${status == 'active'}">
        <div class="task-active">
            <span><i class="fa fa-unlock" aria-hidden="true"></i> PROMIS 10</span>

            <span class="task-date">Aug 15, 2016</span>

            <button class="btn">Start</button>
        </div>

        <g:else>
            <div class="task-schedule">
                <span><i class="fa fa-unlock" aria-hidden="true"></i> PROMIS 10</span>

                <span class="task-date">Aug 15, 2016</span>

                <button class="btn"></button>
            </div>
        </g:else>
    </g:elseif>

</div>
