<%@ page contentType="text/html;charset=UTF-8" %>
<g:set var="scriptPath" value="taskBundle" />
<g:set var="cssPath" value="content" />
<g:applyLayout name="main">
<html>
<head>
    <title>Outcome</title>
</head>
<body>
<div class="content">
    <div class="subtitle">The Disabilities of the Arm, Shoulder and Hand (DASH) Score</div>
    <div class="container col-xs-12 col-sm-10 col-md-8">
        <p>Please rate your ability to do the following activities in the last week.</p>
        <div class="block">
            <span id="collapse-icon">—</span>
            <span class="case">Symptoms </span>
            <span id="collapse-arrow" class="caret-top"></span>
            <span class="minus">- </span>
            <span class="block-desc">These questions should be answered thinking of your knee symptoms during the last week.</span>
            <a class="more" href="#">Read More</a>
        </div>
        <div id="collapse-list">
            <g:each var="outcome" in="${contents}">
                <div class="outcome-list">
                    <div class="wrap">
                        <div class="question">${outcome.question}</div>
                    </div>
                    <ul>
                        <li class="answer">
                            <span>No</span>
                            <span>difficulty</span>
                            <label>
                                <input type="radio" class="choice" name="${outcome.question}" value="Never"/>
                                <span class="radio"></span>
                            </label>
                        </li>
                        <li class="answer">
                            <span>Mid</span>
                            <span>difficulty</span>
                            <label>
                                <input type="radio" class="choice" name="${outcome.question}" value="Rarely"/>
                                <span class="radio"></span>
                            </label>
                        </li>
                        <li class="answer">
                            <span>Moderate</span>
                            <span>difficulty</span>
                            <label>
                                <input type="radio" class="choice" name="${outcome.question}" value="Sometimes"/>
                                <span class="radio"></span>
                            </label>
                        </li>
                        <li class="answer">
                            <span>Severe</span>
                            <span>difficulty</span>
                            <label>
                                <input type="radio" class="choice" name="${outcome.question}" value="Often"/>
                                <span class="radio"></span>
                            </label>
                        </li>
                        <li class="answer">
                            <span>Unable</span>
                            <label>
                                <input type="radio" class="choice" name="${outcome.question}" value="Always"/>
                                <span class="radio"></span>
                            </label>
                        </li>
                    </ul>
                </div>
            </g:each>
        </div>
        <a class="btn-calm" href="resultNoAccount">I'm done</a>
    </div>
</div>
</body>
</html>
</g:applyLayout>
