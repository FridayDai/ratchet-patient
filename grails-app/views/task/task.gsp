<%@ page contentType="text/html;charset=UTF-8" %>
<g:set var="scriptPath" value="taskBundle"/>
<g:set var="cssPath" value="task"/>
<g:applyLayout name="main">
    <html>
    <head>
        <title>Outcome</title>
    </head>

    <body>
    <div class="task-content">
        <div class="container col-xs-12 col-sm-8 col-md-8 col-lg-7">
            <p>Please rate your ability to do the following activities in the last week.</p>

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

            <div class="done">
                <a class="btn-done-task" href="/task/result">I'm Done</a>
            </div>
        </div>
    </div>
    </body>
    </html>
</g:applyLayout>
