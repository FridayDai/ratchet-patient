//= require ../bower_components/headroom.js/dist/headroom
//= require ../bower_components/headroom.js/dist/jQuery.headroom
//= require ../share/announcement


function taskResultBundle() {
    'use strict';

    function init() {
        $("#header").headroom({
            tolerance: {
                down: 10,
                up: 20
            },
            offset: 205,
            onUnpin: function () {
                var headerEl = $('#header');

                if ($('#maintenance').length) {
                    this.classes.unpinned = "headroom--banner--unpinned";

                    if (headerEl.hasClass('headroom--unpinned')) {
                        headerEl.removeClass('headroom--unpinned');
                    }
                } else {
                    this.classes.unpinned = "headroom--unpinned";

                    if (headerEl.hasClass('headroom--banner--unpinned')) {
                        headerEl.removeClass('headroom--banner--unpinned');
                    }
                }
            }
        });
    }

    init();
}

if (window.addEventListener) {
    window.addEventListener("load", taskResultBundle, false);
} else if (window.attachEvent) {
    window.attachEvent("onload", taskResultBundle);
}
