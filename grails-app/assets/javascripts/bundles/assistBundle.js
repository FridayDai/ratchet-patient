//= require ../share/constant
//= require ../share/share

(function($, undefined) {
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

        var browser = window.navigator.userAgent;
        var url = window.location.href;

        return {
            patientId: patientId,
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

        $.ajax({
            url: opts.urls.addAssist,
            type: 'post',
            data: data,
            success: function () {
                _showSuccessMessage();
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

})(jQuery);
