require('../components/common/initSetup');
require('../components/layout/Main');

var flight = require('flight');
var WithForm = require('../components/common/WithForm');
var Notifications = require('../components/common/Notification');

var PatientEmailValidation = require('../components/shared/validation/PatientEmailValidation');

var COMPLETE_TASK_FLAG = "completeTask";

function EmailCollectionPage() {
    this.attributes({
        formSelector: 'form',
        nativeSubmit: true,

        submitButtonSelector: '#enter-email-button',
        skipButtonSelector: '.skip-button',
        emailFieldSelector: '#email',
        pathRouteFieldSelector: 'input[name=pathRoute]'
    });

    this.initValidation = function () {
        return PatientEmailValidation.get();
    };

    this.onSkipButtonClicked = function (e) {
        e.preventDefault();

        var me = this;

        Notifications.confirm({
            title: 'Are you sure?'
        }, {
            buttons: [
                {
                    text: 'Yes',
                    'class': 'btn-agree',
                    click: function () {
                        // Warning dialog close
                        $(this).dialog("close");

                        me.skipEmailCollection();
                    }
                }, {
                    text: 'Cancel',
                    click: function () {
                        $(this).dialog("close");
                    }
                }
            ]
        });
    };

    this.skipEmailCollection = function () {
        this.select('pathRouteFieldSelector').val(COMPLETE_TASK_FLAG);
        this.select('emailFieldSelector').rules('add', {email: false});
        this.select('submitButtonSelector').prop('disabled', true);

        this.formEl.submit();
    };

    this.after('initialize', function () {
        this.on('click', {
            skipButtonSelector: this.onSkipButtonClicked
        });
    });
}

flight.component(WithForm, EmailCollectionPage).attachTo('#main');
