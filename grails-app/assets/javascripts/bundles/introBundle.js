(function (undefined) {
    'use strict';

    function createErrorElement(message) {
        var error = document.createElement('span');
        error.className = 'rc-error-label';
        error.innerText = message;

        return error;
    }

    function errorStatusHandle(el, message) {
        el.className += ' error';

        var errorEl = createErrorElement(message);

        el.parentNode.insertBefore(errorEl, el);
    }

    function clearErrorStatus(el) {
        el.className = el.className.replace(' error', '');

        var error = el.parentNode.querySelector('.rc-error-label');
        el.parentNode.removeChild(error);
    }

    function init() {
        var formEl = document.getElementById('intro-form');

        formEl.addEventListener('submit', function (event) {
            var last4Number = this.querySelector('[name="last4Number"]');

            var reg = /^\d{4}$/;

            if (!reg.test(last4Number.value)) {
                errorStatusHandle(last4Number, 'Last 4 number should be 4 digit!')

                event.returnValue = false;
                return false;
            }
        });

        var last4NumberEl = formEl.querySelector('[name="last4Number"]');

        last4NumberEl.addEventListener('blur', function (event) {
            var reg = /^\d{4}$/;

            if (reg.test(this.value)) {
                clearErrorStatus(this);
            } else {
                errorStatusHandle(this, 'Last 4 number should be 4 digit!');
            }
        })
    }

    init();
})();
