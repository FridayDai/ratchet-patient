//= require ../bower_components/jquery/jquery

(function (undefined) {
    'use strict';

    var opts = {
        urls: {
            emailSettingCheck: "/mail_setting/{0}",
            subscription: "/mail_setting/{0}/subscription"
        }
    };

    var numberInputEl = $('input[name="last4Number"]');

    function isMobileOrTablet() {
        return window.innerWidth < 992;
    }

    function phoneNumberValidation() {
        var regexp = /^\d{4}$/;

        removeErrorMsg();

        if (!regexp.test(numberInputEl.val())) {
            if (isMobileOrTablet()) {
                showConfirmationPop();
            } else {
                setErrorMsg('Invalid input.');
            }
            return false;
        } else {
            removeErrorMsg();
            return true;
        }
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

    function closeDialog() {
        var closeBtnEl = $('#close-btn');

        closeBtnEl.click(function () {
            $("#interact-model-container").removeClass('displayblock').addClass('displaynone');
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
            $('#check-number-button').prop("disabled", false).removeClass("btn-disable").addClass("rc-btn");
            $("#interact-model-container").removeClass('displaynone').addClass('displayblock');
            closeDialog();
            initSubscribeButton();
        }).fail(function (error) {
            if (isMobileOrTablet) {
                showConfirmationPop();
            }
            $('#check-number-button').prop("disabled", false).removeClass("btn-disable").addClass("rc-btn");
            setErrorMsg('Phone number does not match.');
        });
    }

    function initSubscribeButton() {
        var updateBtnEl = $('#btn-update');

        updateBtnEl.click(function () {
            var data = $(this).data();
            var patientId = data.patientId;
            var last4Number = numberInputEl.val();
            var unsubscribe;
            $("#subscribe").attr("checked") === "checked" ? unsubscribe = false : unsubscribe = true;

            subscribeEmail(patientId, last4Number, unsubscribe);
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
        }).done(function (data) {
            $("#interact-model-container").removeClass('displayblock').addClass('displaynone');
        })
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

    function init() {
        start();

        setConfirmation();
    }

    init();
})();
