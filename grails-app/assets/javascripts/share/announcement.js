(function () {
    'use strict';

    var closeEl = document.getElementById('maintenance-close');

    if (closeEl) {
        closeEl.addEventListener('click', function (e) {
            e.preventDefault();

            document.getElementById('maintenance').remove();
        });
    }
})();
