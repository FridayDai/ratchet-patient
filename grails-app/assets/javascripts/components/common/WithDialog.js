require('../../libs/dialog');

var flight = require('flight');
var WithOptions = require('./WithOptions');

function WithDialog() {
    flight.compose.mixin(this, [
        WithOptions
    ]);

    this.defaultOptions = {
        autoOpen: false,
        height: 'auto',
        resizable: false,
        modal: true,
        delayFocus: 700
    };

    this._initDialog = function () {
        this.dialogEl = this.$node.dialog(this.initOptions());
    };

    this.options = function (options) {
        if (_.isArray(options.buttons) &&
            options.buttons.length === 1 &&
            _.isString(options.buttons[0])) {
            var originButtons = options.buttons;
            var primaryButtonStr = originButtons[0];

            options.buttons = {};

            options.buttons[primaryButtonStr] = function () {
                this.close();
            };
        }

        this._options = options;
    };

    this.show = function () {
        this.dialogEl.dialog('open');
    };

    this.close = function () {
        this.dialogEl.dialog('close');
    };

    this.changeTitle = function (title) {
        this.dialogEl.dialog('option', 'title', title);
    };

    this.changeWidth = function (width) {
        this.dialogEl.dialog('option', 'width', width);
    };

    this.after('initialize', function () {
        this._initDialog();
    });

    this.before('teardown', function () {
        this.$node.off('dialogopen dialogprepareclose');
        this.$node.dialog('destroy');
        this.dialogEl = null;
    });
}

module.exports = WithDialog;
