function announcementHandle () {
    'use strict';

    var maintenanceEl = $('#maintenance');
    var closeEl = $('#maintenance-close');

    if (closeEl) {
        closeEl.click(function (e) {
            e.preventDefault();

            var announcementLastUpdate = maintenanceEl.data('announcementLastUpdate');

            $.get('/announcement/close?announcementLastUpdate=' + announcementLastUpdate);

            maintenanceEl.remove();
        });
    }
}

if (window.addEventListener)
    window.addEventListener("load", announcementHandle, false);
else if (window.attachEvent)
    window.attachEvent("onload", announcementHandle);
