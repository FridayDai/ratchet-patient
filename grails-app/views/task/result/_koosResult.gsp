<div class="score-header">
    <% def completeScores = "" %>
    <% def singleScore%>
    <% if(completeTask.nrsScore != null) {%>
    <% completeScores = completeTask.nrsScore?.split(',') }%>
    <g:each in="${completeScores}" var="num">
        <% singleScore = num.trim().split(':') %>
        <g:if test="${singleScore.size() == 2}">
            <p class="capitalize">${singleScore[0].replaceAll("_", "/" ).toLowerCase()} Score: ${singleScore[1]}</p>
        </g:if>
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

        <g:each in="${completeTask.comparison}" var="compare">
            <p class="bottom-content">${compare} based on <g:formatDate
                    date="${new java.util.Date(completeTask.lastScoreTime)}"
                    timeZone="${TimeZone.getTimeZone('America/Vancouver')}"
                    format="MMM d, yyyy"></g:formatDate> measurement</p>
        </g:each>

    </div>
</g:if>
