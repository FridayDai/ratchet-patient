require('../../libs/jquery-validation/jquery.validate.js');
require('jForm');

function WithForm() {
    this.attributes({
        formSelector: '.'
    });

    this._initForm = function () {
        if (this.attr.formSelector === '.') {
            this.formEl = $(this.$node);
        } else {
            this.formEl = this.select('formSelector');
        }

        this._setDefaultValidation();

        var options;
        if ($.isFunction(this.initValidation)) {
            options = this.initValidation();
        }

        if (!this.attr.nativeSubmit) {
            _.extend(options, {
                submitHandler: _.bind(this._prepareSubmitForm, this)
            });
        }

        this.formEl.validate(options);
    };

    this.submitForm = function () {
        var data;

        if (_.isFunction(this.setExtraData)) {
            data = this.setExtraData();
        }

        var $submitButton = this.formEl.find('button[type="submit"]');
        $submitButton.prop('disabled', true);

        this.formEl.ajaxSubmit({
            data: data,
            success: _.bind(this._formSuccess, this),
            error: _.bind(this._formFail, this),
            complete: function () {
                $submitButton.prop('disabled', false);
            }
        });
    };

    this._prepareSubmitForm = function () {
        if (_.isFunction(this.beforeSubmitForm)) {
            if (this.beforeSubmitForm() === false) {
                return;
            }
        }

        this.submitForm();
    };

    this._formSuccess = function (data) {
        if (!data || _.isString(data)) {
            data = {resp: data};
        }

        this.trigger('formSuccess', data);
    };

    this._formFail = function (data) {
        if (!data || _.isString(data)) {
            data = {resp: data};
        }

        this.trigger('formFail', data);
    };

    this._setDefaultValidation = function () {
        $.validator.setDefaults({
            errorClass: 'rc-error-label',
            errorPlacement: function(error, element) {
                $("<div class='error-container'></div>").appendTo(element.parent()).append(error);
            }
        });
    };

    this.after('initialize', function () {
        this._initForm();
    });

    this.before('teardown', function () {
        this.formEl.data('validator', null);
        this.formEl = null;
    });
}

module.exports = WithForm;
