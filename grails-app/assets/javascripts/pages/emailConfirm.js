require('../components/layout/Main');
require('../libs/jquery.validate.js');

var flight = require('flight');
var WithPage = require('../components/common/WithPage');
var STRINGs = require('../constants/Strings');

function EmailConfirm() {

    this.attributes({
        formSelector: 'form',
        contentSelector: '#form-content',
        agreeButtonSelector: '#agree-toggle',
        birthdayInputSelector: '#birthday',
        gspErrorMsgSelector: '.gsp-error'
    });


    this.onAgreeButtonClicked = function () {
        var content = this.select('contentSelector');
        if (!this.select('agreeButtonSelector').is(':checked')) {
            content.addClass('error');
        } else {
            content.removeClass('error');
        }
    };

    this.onSubmitButtonClicked = function () {
        var content = this.select('contentSelector');

        $(this.attr.formSelector).valid();
        this.AddlistenToCheckBox();

        if (!this.select('agreeButtonSelector').is(':checked')) {
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

    this.initValidation = function () {
        $.validator.setDefaults({
            errorClass: 'rc-error-label',
            errorPlacement: function(error, element) {
                element.parent().find('.gsp-error').remove();
                $("<div class='error-container'></div>").appendTo(element.parent()).append(error);
            }
        });

        $.validator.addMethod("year", function (value, element) {
            return this.optional(element) || /^\d{4}$/.test(value);
        }, "Please enter a valid year.");

        $(this.attr.formSelector).validate({
            rules: {
                birthday: {
                    required: true,
                    year: true
                }
            },
            messages: {
                birthday: {
                    required: STRINGs.YEAR_REQUIRED
                }
            }
        });
    };

    this.checkErrorMsg = function () {
        var self = this;
        $(this.attr.birthdayInputSelector).one("input", function () {
            self.select('gspErrorMsgSelector').remove();
        });
    };

    this.after('initialize', function () {
        this.initValidation();
        this.checkErrorMsg();
        this.on('submit', this.onSubmitButtonClicked);
    });
}

flight.component(WithPage, EmailConfirm).attachTo('form');


