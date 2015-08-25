//= require ../share/constant

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
        setConfirmation();
    }

    init();
})();
