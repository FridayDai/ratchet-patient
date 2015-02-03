<%@ page contentType="text/html;charset=UTF-8" %>
<g:set var="scriptPath" value="taskBundle"/>
<g:set var="cssPath" value="intro"/>
<g:applyLayout name="main">
    <html>
    <head>
        <title>Task Intro</title>
    </head>

    <body>
    <div class="content col-xs-12 col-sm-9 col-md-8">
        <div class="intro">INTRO</div>

        <div class="desc">This questionnaire asks about your symptoms as well as your ability to perform certain activities. Please answer every question , based on your condition in the last week. If you did not have the opportunity to perform an activity in the past week, please make your best estimate on which response would be the most accurate. It doesn't matter which hand or arm you use to perform the activity; please answer based on you ability regardless of how you perform the task.</div>

        <div class="phone">
            <p>Enter the last 4 digit of your phone #:</p>
            <input type="text" placeholder="Enter last 4 digits"/>
            <a class="btn btn-start-task" href="/task">Start</a>

            <span class="caret-left"></span>

            <div class="tip">Sorry for the inconvenience,this is required in order for us to help you protect your data.<img
                    class="close-tip" src="${assetPath(src: 'close-tip.png')}" alt=""/></div>

        </div>
    </div>
    </body>
    </html>
</g:applyLayout>
