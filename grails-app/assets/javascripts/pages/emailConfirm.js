require('../components/layout/Main');

var flight = require('flight');
var WithPage = require('../components/common/WithPage');

function EmailConfirm() {

    this.attributes({
        formSelector: 'form',
        contentSelector: '#form-content',
        agreeButtonSelector: '#agree-toggle'
    });

    this.onAgreeButtonClicked = function () {
        var content = this.select('contentSelector');
        if(!this.select('agreeButtonSelector').is(':checked')) {
            content.addClass('error');
        } else {
            content.removeClass('error');
        }
    };

    this.onSubmitButtonClicked = function () {
        var content = this.select('contentSelector');

        this.AddlistenToCheckBox();

        if(!this.select('agreeButtonSelector').is(':checked')) {
            content.addClass('error');
            return false;
        } else {
            content.removeClass('error');
        }
    };

    this.AddlistenToCheckBox = _.once(function () {
        var self = this;
        this.on('click', {
            agreeButtonSelector: self.onAgreeButtonClicked
        });
    });

    this.after('initialize', function () {
        this.on('submit', this.onSubmitButtonClicked);

    });
}

flight.component(WithPage, EmailConfirm).attachTo('form');


