(function(undefined) {
    var RC = window.RC = window.RC || {};

    function constantHandle() {
        'use strict';
        var constants = RC.constants = RC.constants || {};

        $.extend(constants, {

            //phone number error
            phoneNumberTypeError: "Invalid input.",
            phoneNumberNotMatch: "Phone number does not match.",
            phoneNumberNotCorrect: "The number you entered is incorrect. Please try again."

        });
    }

    if (window.addEventListener) {
        window.addEventListener("load", constantHandle, false);
    } else if (window.attachEvent) {
        window.attachEvent("onload", constantHandle);
    }
})();
