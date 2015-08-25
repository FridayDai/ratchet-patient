//= require ../share/constant

(function (undefined) {
    'use strict';

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
