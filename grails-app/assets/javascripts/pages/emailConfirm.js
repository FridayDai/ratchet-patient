require('../components/layout/Main');

var flight = require('flight');
var WithPage = require('../components/common/WithPage');

function EmailConfirm() {

    this.onSubmitButtonClicked = function () {

    };

    this.after('initialize', function () {
        this.on('submit', this.onSubmitButtonClicked);
    });
}

flight.component(WithPage, EmailConfirm).attachTo('#confirm-form');


