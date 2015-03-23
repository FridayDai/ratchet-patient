(function () {
    'use strict';

    document
        .getElementById('maintenance-close')
        .addEventListener('click', function (e) {
            e.preventDefault();

            document.getElementById('maintenance').remove();
        });
})();
