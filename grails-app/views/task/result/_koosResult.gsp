<%@ page import="com.ratchethealth.patient.RatchetStatusCode; com.ratchethealth.patient.RatchetMessage" %>
<div class="score-header">
    <% def completeScores = "" %>
    <% def singleScore%>
    <% if(completeTask.nrsScore != null) {%>
    <% completeScores = completeTask.nrsScore?.split(',') }%>
    <g:each in="${completeScores}" var="num">
        <% singleScore = num.trim().split(':') %>
        <g:if test="${singleScore.size() == 2}">
            <p class="capitalize">${RatchetStatusCode.TASK_OOS_SCORE[singleScore[0]]} Score: ${singleScore[1]}</p>
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
        <div class="report-title">Comparison:</div>

        <g:each in="${completeTask.comparison}" var="compare" status="i">
            <p class="bottom-content"> ${RatchetStatusCode.TASK_OOS_SCORE[compare.key]} Score: ${compare.value} based on <g:formatDate
                    date="${new java.util.Date(completeTask.lastScoreTime)}"
                    timeZone="${TimeZone.getTimeZone('America/Vancouver')}"
                    format="MMM d, yyyy"></g:formatDate> measurement</p>
        </g:each>

    </div>
</g:if>
