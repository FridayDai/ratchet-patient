<div class="score-header">Score: ${completeTask.score as float}</div>

<div class="score-content">
    <p class="inner-content content-header">Interpretaion:</p>

    <p class="inner-content content-list">0 = least disability</p>

    <p class="inner-content content-list">100 = most disability</p>

    <g:if test="${completeTask.type == 1 || completeTask.type == 6}">
        <p class="inner-content content-list">10.1 = general population score</p>
    </g:if>
    <g:elseif test="${completeTask.type == 2}">
        <p class="inner-content content-list">10.2 = general population score</p>
    </g:elseif>
    <g:else>
        <p class="inner-content content-list">6.98 = general population score</p>
    </g:else>

</div>

<g:if test="${completeTask.comparison}">
    <div class="report-bottom">
        <p class="bottom-content">Comparison:</p>

        <p class="bottom-content">${completeTask.comparison} based on <g:formatDate
                date="${new java.util.Date(completeTask.lastScoreTime)}"
                timeZone="${TimeZone.getTimeZone('America/Vancouver')}"
                format="MMM d, yyyy"></g:formatDate> measurement</p>
    </div>
</g:if>
