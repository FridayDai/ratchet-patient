<div class="score-header">
    <g:each in="${scores}" var="">
        <p>Score: ${completeTask.score as float}</p>
    </g:each>
</div>

<div class="score-content">
    <p class="inner-content content-header">Interpretaion:</p>

    <p class="inner-content content-list">100 = no problems</p>

    <p class="inner-content content-list">0 = extreme problems</p>
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
