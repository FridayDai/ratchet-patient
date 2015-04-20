function announcementHandle () {
    'use strict';

    var maintenanceEl = $('#maintenance');
    var closeEl = $('#maintenance-close');

    if (closeEl) {
        closeEl.click(function (e) {
            e.preventDefault();

            var announcementLastUpdated = maintenanceEl.data('announcementLastUpdated');

            //$.get('/announcement/close?announcementLastUpdated=' + announcementLastUpdated);

            maintenanceEl.remove();
        });
    }
}

if (window.addEventListener)
    window.addEventListener("load", announcementHandle, false);
else if (window.attachEvent)
    window.attachEvent("onload", announcementHandle);
