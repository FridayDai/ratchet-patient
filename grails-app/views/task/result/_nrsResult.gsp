<g:if test="${completeTask.type == 4}">
    <div class="score-header">Back Score:${completeTask.nrsScore1}</div>

    <div class="score-header">Leg Score:${completeTask.nrsScore2}</div>
</g:if>
<g:else>
    <div class="score-header">Neck Score:${completeTask.nrsScore1}</div>

    <div class="score-header">Arm Score:${completeTask.nrsScore2}</div>
</g:else>

<div class="score-content">
    <p class="inner-content content-header">Interpretaion:</p>

    <p class="inner-content content-list">0 = no pain</p>

    <p class="inner-content content-list">1-3 = mild pain(nagging,annoying,interfering,little with activities of daily living)</p>

    <p class="inner-content content-list">4-6 =moderate pain (interferes significantly with activities of daily living)</p>

    <p class="inner-content content-list">7-10 =severe pain(disabling;unable to perform activities of daily living)</p>
</div>

<g:if test="${completeTask.comparison}">
    <div class="report-bottom">
        <p class="bottom-content">Comparison:</p>

        <g:if test="${completeTask.type == 4}">
            <p class="bottom-content">Back:${completeTask.comparison.back} based on <g:formatDate
                    date="${new java.util.Date(completeTask.lastScoreTime)}"
                    timeZone="${TimeZone.getTimeZone('America/Vancouver')}"
                    format="MMM d, yyyy"></g:formatDate> measurement</p>

            <p class="bottom-content">Leg:${completeTask.comparison.leg} based on <g:formatDate
                    date="${new java.util.Date(completeTask.lastScoreTime)}"
                    timeZone="${TimeZone.getTimeZone('America/Vancouver')}"
                    format="MMM d, yyyy"></g:formatDate> measurement</p>
        </g:if>
        <g:else>
            <p class="bottom-content">Neck:${completeTask.comparison.neck} based on <g:formatDate
                    date="${new java.util.Date(completeTask.lastScoreTime)}"
                    timeZone="${TimeZone.getTimeZone('America/Vancouver')}"
                    format="MMM d, yyyy"></g:formatDate> measurement</p>

            <p class="bottom-content">Arm:${completeTask.comparison.arm} based on <g:formatDate
                    date="${new java.util.Date(completeTask.lastScoreTime)}"
                    timeZone="${TimeZone.getTimeZone('America/Vancouver')}"
                    format="MMM d, yyyy"></g:formatDate> measurement</p>
        </g:else>
    </div>
</g:if>
