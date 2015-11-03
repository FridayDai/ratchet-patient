require('../components/common/initSetup');
require('../components/layout/Main');

var flight = require('flight');
var WithForm = require('../components/common/WithForm');

function AssistPage() {
    this.attributes({
        titleLabelSelector: 'h1.title',
        formSelector: '#assist-form',
        submitButtonSelector: '#assist-me',
        nameLabelSelector: '#assist-name',
        successPanelSelector: '.success-message'
    });

    this.setExtraData = function () {
        var $submit = this.select('submitButtonSelector');
        var patientId = $submit.data('patientid');
        var careGiverId = $submit.data('careGiverId');
        var name = this.select('nameLabelSelector').text();
        var browser = window.navigator.userAgent;
        var url = window.location.href;

        return {
            patientId: patientId,
            careGiverId: careGiverId,
            name: name,
            browser: browser,
            url: url
        };
    };

    this.onSendAssistSuccess = function () {
        this.select('formSelector').hide();
        this.select('titleLabelSelector').addClass('success');
        this.select('successPanelSelector').show();
    };

    this.after('initialize', function () {
        this.on('formSuccess', this.onSendAssistSuccess);
    });
}

flight.component(WithForm, AssistPage).attachTo('#main');
