var flight = require('flight');
var WithDialog = require('../common/WithDialog');
var Utility = require('../../utils/Utility');
var URLs = require('../../constants/Urls');

function SubscribeDialog() {
    this.attributes({
        subscribeCheckboxSelector: '#subscribe'
    });

    var options = {
        title: 'EDIT EMAIL SETTING',
        buttons: [{
            text: 'Update Setting',
            'class': 'rc-primary-color',
            click: function() {
                this.subscribeEmail();
            }
        }]
    };

    if (Utility.isMobile()) {
        options.width = 360;
    } else {
        options.width = 480;
    }

    this.options(options);

    this.last4Number = null;

    this.onShow = function (e, data) {
        this.last4Number = data.last4Number;

        this.$node.removeClass('ui-hidden');
        this.show();
    };

    this.subscribeEmail = function () {
        var me = this;

        $.ajax({
            url: URLs.EMAIL_SETTING_SUBSCRIPTION.format(this.$node.data('patientId')),
            type: 'POST',
            data: {
                last4Number: this.last4Number,
                subscribe: this.select('subscribeCheckboxSelector').prop('checked') === true
            }
        }).done(function () {
            me.close();
        });
    };
}

module.exports = flight.component(WithDialog, SubscribeDialog);
