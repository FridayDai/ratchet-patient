//= require ../share/constant
//= require ../share/announcement

(function (undefined) {
    'use strict';

    function createErrorElement(message) {
        var error = document.createElement('span');
        error.className = 'rc-error-label';
        error.innerText = message;

        return error;
    }

    function isMobileOrTablet() {
        return window.innerWidth < 992;
    }

    function errorStatusHandle(el, message) {
        var regex = /\serror($|\s)/;
        var parentNode = el.parentNode;

        if (regex.test(parentNode.className) || isMobileOrTablet()) {
            return false;
        }

        parentNode.className += ' error';

        var errorEl = createErrorElement(message);

        parentNode.insertBefore(errorEl, el.nextSibling);
    }

    function clearErrorStatus(el) {
        var parentNode = el.parentNode;

        parentNode.className = parentNode.className.replace(' error', '');

        var error = parentNode.querySelector('.rc-error-label');

        if (error) {
            parentNode.removeChild(error);
        }
    }

    function showConfirmationPop() {
        var coverEl = document.getElementById('mobile-alert-cover');
        var containerEl = document.getElementById('mobile-alert-container');
        var regexp = /\sshow($|\s)/;

        if (!regexp.test(coverEl.className)) {
            coverEl.className += ' show';
        }

        if (!regexp.test(containerEl.className)) {
            containerEl.className += ' show';
        }
    }

    function setForm() {
        var formEl = document.getElementById('intro-form');

        formEl.addEventListener('submit', function (event) {
            var last4Number = this.querySelector('[name="last4Number"]');

            var reg = /^\d{4}$/;

            if (!reg.test(last4Number.value)) {
                errorStatusHandle(last4Number, RC.constants.phoneNumberTypeError);

                if (isMobileOrTablet()) {
                    showConfirmationPop();
                }

                event.returnValue = false;
                return false;
            }
        });

        var last4NumberEl = formEl.querySelector('[name="last4Number"]');

        last4NumberEl.addEventListener('blur', function () {
            var reg = /^\d{4}$/;

            if (reg.test(this.value)) {
                clearErrorStatus(this);
            } else {
                errorStatusHandle(this, 'Invalid input.');
            }
        });
    }

    function setConfirmation() {
        var coverEl = document.getElementById('mobile-alert-cover');
        var containerEl = document.getElementById('mobile-alert-container');
        var buttonEl = containerEl.querySelector('button');

        buttonEl.addEventListener('click', function () {
            coverEl.className = coverEl.className.replace(' show', '');
            containerEl.className = containerEl.className.replace(' show', '');
        });
    }

    function init() {
        setForm();

        setConfirmation();
    }

    init();
})();
