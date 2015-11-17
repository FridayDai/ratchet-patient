var flight = require('flight');
var WithForm = require('../common/WithForm');
var STRINGs = require('../../constants/Strings');

var last4NumberValidation = require('../shared/validation/last4NumberValidation');

function MainPanel() {
    this.attributes({
        last4NumberFieldSelector: '#last4Number',
        last4NumberCheckButtonSelector: '#check-number-button',
        last4NumberErrorLabelSelector:".rc-error-label"
    });

    this.initValidation = function () {
        return last4NumberValidation.get();
    };

    this.onCheckLast4NumberSuccess = function () {
        this.trigger('showSubscribeDialog', {
            last4Number: this.select('last4NumberFieldSelector').val().trim()
        });
    };

    this.onCheckLast4NumberFail = function () {
        this.select('last4NumberErrorLabelSelector').text(STRINGs.phoneNumberNotMatch);
    };

    this.after('initialize', function () {
        this.on('formSuccess', this.onCheckLast4NumberSuccess);
        this.on('formFail', this.onCheckLast4NumberFail);
    });
}

module.exports = flight.component(WithForm, MainPanel);
