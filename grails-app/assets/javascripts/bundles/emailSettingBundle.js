//= require ../share/constant
//=require ../share/announcement

(function () {
    String.prototype.format = function () {
        var str = this;
        if (arguments.length === 0) {
            return str;
        }

        for (var i = 0; i < arguments.length; i++) {
            var re = new RegExp('\\{' + i + '\\}', 'gm');
            if (arguments[i] !== undefined || arguments[i] !== null) {
                str = str.replace(re, arguments[i]);
            } else {
                str = str.replace(re, '');
            }
        }
        return str;
    };

    function isMobileOrTablet() {
        return window.innerWidth < 992;
    }

    var numberInputEl;

    function setDialogErrorMsg(msg) {
        var parentEl = numberInputEl.parents();
        var mobileAlertTitleEl = parentEl.find(".mobile-alert-title");
        mobileAlertTitleEl.after('<div class="mobile-alert-content">' + msg + '</div>');
    }

    function removeDialogErrorMsg() {
        var parentEl = numberInputEl.parents();
        var mobileAlertContentEl = parentEl.find(".mobile-alert-content");
        mobileAlertContentEl.remove();
    }

    function setErrorMsg(msg) {
        var parentEl = numberInputEl.parent();

        if (!parentEl.hasClass('error')) {
            parentEl.addClass('error');
            numberInputEl.after('<span class="rc-error-label">' + msg + '</span>');
        }
    }

    function removeErrorMsg() {
        var parentEl = numberInputEl.parent();

        if (parentEl.hasClass('error')) {
            parentEl.removeClass('error');
            parentEl.find('.rc-error-label').remove();
        }
    }

    function showConfirmationPop() {
        var coverEl = $("#mobile-alert-cover");
        var containerEl = $("#mobile-alert-container");
        var regexp = /\sshow($|\s)/;

        if (!regexp.test(coverEl.className)) {
            coverEl.addClass("show");
        }

        if (!regexp.test(containerEl.className)) {
            containerEl.addClass("show");
        }
    }

    function emailSettingBundle(undefined) {
        'use strict';

        var opts = {
            urls: {
                emailSettingCheck: "/mail_setting/{0}",
                subscription: "/mail_setting/{0}/subscription"
            }
        };

        numberInputEl = $('input[name="last4Number"]');

        function phoneNumberValidation() {
            var regexp = /^\d{4}$/;

            removeErrorMsg();
            removeDialogErrorMsg();

            if (!regexp.test(numberInputEl.val())) {

                if (isMobileOrTablet()) {
                    setDialogErrorMsg(RC.constants.phoneNumberTypeError);
                    showConfirmationPop();
                } else {
                    setErrorMsg(RC.constants.phoneNumberTypeError);
                }
                return false;
            } else {
                removeErrorMsg();
                return true;
            }
        }

        function closeDialog() {
            var closeBtnEl = $('#close-btn');

            closeBtnEl.click(function () {
                $("#interact-model-container")
                    .removeClass('show')
                    .removeClass('fade')
                    .removeClass('in')
                    .addClass('hide');

                $("#interact-alert-cover")
                    .removeClass('show')
                    .addClass('hide');
            });
        }

        function checkPhoneNumber(patientId) {
            $.ajax({
                url: opts.urls.emailSettingCheck.format(patientId),
                type: 'POST',
                data: {
                    last4Number: numberInputEl.val()
                }
            }).done(function (data) {
                $("#unSubscribe").prop("checked", data.subscribeStatus | false);

                $('#check-number-button')
                    .prop("disabled", false)
                    .removeClass("btn-disable")
                    .addClass("rc-btn");

                $("#interact-model-container")
                    .removeClass('hide')
                    .addClass('fade');

                setTimeout(function () {
                    $("#interact-model-container").addClass("in");
                }, 300);

                $("#interact-alert-cover")
                    .removeClass('hide')
                    .addClass('show');

                closeDialog();
                initSubscribeButton();

            }).fail(function () {
                if (isMobileOrTablet()) {
                    setDialogErrorMsg(RC.constants.phoneNumberNotCorrect);
                    showConfirmationPop();
                }
                $('#check-number-button')
                    .prop("disabled", false)
                    .removeClass("btn-disable")
                    .addClass("rc-btn");

                setErrorMsg(RC.constants.phoneNumberTypeError);
            });
        }

        function initSubscribeButton() {
            var updateBtnEl = $('#btn-update');

            updateBtnEl.click(function () {
                var data = $(this).data();
                var patientId = data.patientId;
                var last4Number = numberInputEl.val();
                subscribeEmail(patientId, last4Number, $("#unSubscribe").prop("checked") !== true);
            });
        }

        function subscribeEmail(patientId, last4Number, unsubscribe) {
            $.ajax({
                url: opts.urls.subscription.format(patientId),
                type: 'POST',
                data: {
                    last4Number: last4Number,
                    unsubscribe: unsubscribe
                }
            }).done(function () {
                $("#interact-model-container")
                    .removeClass('show')
                    .removeClass('fade')
                    .removeClass('in')
                    .addClass('hide');

                $("#interact-alert-cover")
                    .removeClass('show')
                    .addClass('hide');
            });
        }

        function initCheckButton() {
            var btnEl = $('#check-number-button');

            btnEl.click(function () {
                var data = $(this).data();
                var patientId = data.patientId;

                if (phoneNumberValidation()) {
                    btnEl.prop("disabled", true).removeClass("rc-btn").addClass("btn-disable");
                    checkPhoneNumber(patientId);
                }
            });
        }

        function initPhoneNumberCheck() {
            initCheckButton();
        }

        function start() {
            initPhoneNumberCheck();
        }

        function setConfirmation() {
            var coverEl = $("#mobile-alert-cover");
            var containerEl = $("#mobile-alert-container");
            var buttonEl = containerEl.find("button");

            buttonEl.on('click', function () {
                coverEl.removeClass("show");
                containerEl.removeClass("show");
            });
        }

        function init() {
            start();

            setConfirmation();
        }

        init();
    }

    if (window.addEventListener) {
        window.addEventListener("load", emailSettingBundle, false);
    } else if (window.attachEvent) {
        window.attachEvent("onload", emailSettingBundle);
    }
})();
