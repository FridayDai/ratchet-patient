require('../../libs/dialog');

var flight = require('flight');
var WithOptions = require('./WithOptions');
var Utility = require('../../utils/Utility');

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

    this.setTitle = this.changeTitle = function (title) {
        this.dialogEl.dialog('option', 'title', title);
    };

    this.changeWidth = function (width) {
        this.dialogEl.dialog('option', 'width', width);
    };

    this.changeHeight = function (height) {
        this.dialogEl.dialog('option', 'height', height);
    };

    this.changeSize = function (size) {
        this.changeHeight(size.height);
        this.changeWidth(size.width);
    };

    this._onShowWrapper = function () {
        if (_.isFunction(this.onShow)) {
            this._customOnShow = this.onShow;
        }

        this.onShow = function (e, data) {
            var $window = $(window);

            this.$node.removeClass('ui-hidden');

            var height = window.innerHeight ? window.innerHeight : $(window).height();

            if (Utility.isMobile()) {
                this.changeSize({
                    width: $window.width(),
                    height: height
                });

                this.__bodyScrollTop = $('body')[0].scrollTop;
            } else {
                this.changeSize({
                    height: 'auto'
                });
            }

            if (_.isFunction(this._customOnShow)) {
                this._customOnShow.call(this, e, data);
            }

            this.show();
        };
    };

    this.initMobileTouchEndEvent = function () {
        if (Utility.isMobile()) {
            this.__touchendWrapper = _.bind(this.onBodyTouchend, this);
            $('body').on('touchend', this.__touchendWrapper);
        }
    };

    this.onBodyTouchend = function() {
        if(this.$node.is(':visible')) {
            $('body')[0].scrollTop = this.__bodyScrollTop;
        }
    };

    this.after('initialize', function () {
        this._initDialog();
        this._onShowWrapper();

        this.initMobileTouchEndEvent();
    });

    this.before('teardown', function () {
        this.$node.off('dialogopen dialogprepareclose');
        this.$node.dialog('destroy');
        this.dialogEl = null;

        if (Utility.isMobile()) {
            $('body').off('touchend', this.__touchendWrapper);
        }
    });
}

module.exports = WithDialog;
