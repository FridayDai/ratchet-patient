//= require ../share/constant
//= require ../share/announcement


(function () {

    function emailValid() {
        var email = $("#email").val();
        var regexp = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/; // jshint ignore:line
        if(regexp.test(email)) {
            return true;
        }
            return false;
    }

    function showConfirmationPop() {

        var containerEl = $("#dialog-alert-container");
        var regexp = /\sshow($|\s)/;

        if (!regexp.test(containerEl.className)) {
            containerEl.addClass("show");
        }
    }

    function post(path, params, method) {
        method = method || "post"; // Set method to post by default if not specified.

        // The rest of this code assumes you are not using a library.
        // It can be made less wordy if you use one.
        var form = document.createElement("form");
        form.setAttribute("method", method);
        form.setAttribute("action", path);

        for(var key in params) {
            if(params.hasOwnProperty(key)) {
                var hiddenField = document.createElement("input");
                hiddenField.setAttribute("type", "hidden");
                hiddenField.setAttribute("name", key);
                hiddenField.setAttribute("value", params[key]);

                form.appendChild(hiddenField);
            }
        }

        document.body.appendChild(form);
        form.submit();
    }


    function clinicEnterEmailBundle(undefined) {
        'use strict';

        var opts = {
            urls: {
                enterEmail: '/in-clinic'
            }
        };

        function showErrorMessage() {

            var errorContainer =  $('#error-container');
            var errorLabel;
            if(errorContainer.children().length > 0) {
                errorLabel =  $("#error-msg");
                errorLabel.text('Invalid Email');
            } else{
                var html =  '<span id="error-msg" class="rc-error rc-error-label">Invalid Email</span>';
                errorContainer.append(html);
            }
        }

        function closeDialog() {
            var closeBtnEl = $('#close-btn');

            closeBtnEl.click(function () {
                $("#dialog-alert-container")
                    .removeClass('show');
            });
        }

        function skipEnterEmail() {
            var btnEl = $('#jump-btn');
            var data = {
                clinicPathRoute: 'completeTask',
                tasksList: $('input[name="tasksList"]').val(),
                treatmentCode: $('input[name="treatmentCode"]').val()
            };

            btnEl.click(function () {
                post(opts.urls.enterEmail, data);
            });
        }

        function start() {
            var skip = $('#skip-button');
            skip.click(function(){
                showConfirmationPop();
            });

            var emailForm = $('#email-enter-form');
            emailForm.submit(function(e) {
                if(!emailValid()) {
                    e.preventDefault();
                    showErrorMessage();
                }
            });
        }

        function init() {
            skipEnterEmail();
            closeDialog();
            start();
        }

        init();
    }

    if (window.addEventListener) {
        window.addEventListener("load", clinicEnterEmailBundle, false);
    } else if (window.attachEvent) {
        window.attachEvent("onload", clinicEnterEmailBundle);
    }
})();
