<%@ page contentType="text/html;charset=UTF-8" %>
<g:set var="scriptPath" value="" />
<g:set var="cssPath" value="task/result" />
<g:applyLayout name="taskLayout">
<html>
<head>
    <title></title>
</head>
<body>
  <div class="result-content">
     <div class="container col-xs-12 col-sm-9 col-md-9 col-lg-8 clear">
         <div class="top">
             <div class="para1">COMPLETED!</div>
             <div class="para2">Thank you for completing the task!</div>
             %{--<p class="para3">The Disabilities of the Arm, Shoulder and Hand (DASH) Score is:</p>--}%
             %{--<p class="para4">29.92</p>--}%
         </div>
         %{--<div class="bottom">--}%
              %{--<p class="reminder">Click here to create an account on Proliance Patient portal name to manage your tasks and view their result.</p>--}%
              %{--<a class="btn-create-account">Create Account</a>--}%
         %{--</div>--}%
     </div>
  </div>
</body>
</html>
</g:applyLayout>
