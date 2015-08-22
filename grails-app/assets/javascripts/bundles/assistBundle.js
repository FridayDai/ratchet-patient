//= require ../share/constant
//= require ../share/share

function assistBundle(undefined) {
    'use strict';

    var opts = {
        urls: {
            addAssist: "/addAssist"
        }
    };

    function _getAssistData() {
        var title = $('#assist-title').val();
        var desc = $('#assist-desc').val();
        var name = $('#assist-name').html();
        var patientId = $('#assist-me').data('patientid');
        var careGiverId = $('#assist-me').data('careGiverId');

        var browser = window.navigator.userAgent;
        var url = window.location.href;

        return {
            patientId: patientId,
            careGiverId: careGiverId,
            title: title,
            desc: desc,
            name: name,
            browser: browser,
            url: url
        };
    }

    function _showSuccessMessage() {
        $('.success-message').show();
        $('#assist-form').hide();
    }

    function _sendAssistReport() {
        var data = _getAssistData();
        var $submitButton = $('button[type="submit"]');

        $submitButton.prop('disabled', true);

        $.ajax({
            url: opts.urls.addAssist,
            type: 'post',
            data: data,
            success: function () {
                _showSuccessMessage();
            },
            complete: function () {
                $submitButton.prop('disabled', false);
            }
        });
    }

    function _bindAssistEvent() {
        $('#assist-me').on('click', function (e) {
            e.preventDefault();

            if ($('#assist-form').valid()) {
                _sendAssistReport();
            }
        });
    }

    _bindAssistEvent();
}

if (window.addEventListener) {
    window.addEventListener("load", assistBundle, false);
} else if (window.attachEvent) {
    window.attachEvent("onload", assistBundle);
}
