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
            // var bodyEl = $('body')[0];

            this.$node.removeClass('ui-hidden');

            var height = window.innerHeight ? window.innerHeight : $(window).height();

            if (Utility.isMobile()) {
                this.changeSize({
                    width: $window.width(),
                    height: height
                });

                // this.__bodyScrollTop = bodyEl.scrollTop;
            } else {
                this.changeSize({
                    height: 'auto'
                });
            }

            if (_.isFunction(this._customOnShow)) {
                this._customOnShow.call(this, e, data);
            }

            this.show();

            // if (Utility.isMobile()) {
            //     bodyEl.scrollTop = this.__bodyScrollTop;
            // }
        };
    };

    // this.initMobileTouchEndEvent = function () {
    //     if (Utility.isMobile()) {
    //         this.__touchstartWrapper = _.bind(this.onBodyTouchStart, this);
    //         this.__touchmoveWrapper = _.bind(this.onBodyTouchMove, this);
    //
    //         var $body = $('body');
    //
    //         $body.on('touchstart', this.__touchstartWrapper);
    //         $body.on('touchmove', this.__touchmoveWrapper);
    //     }
    // };
    //
    // this.__findDialogContent = function () {
    //     var $content = this.$node.find('.ui-dialog-content');
    //
    //     if (!$content.length) {
    //         $content = this.$node.closest('.ui-dialog-content');
    //     }
    //
    //     return $content;
    // };
    //
    // this.onBodyTouchStart = function (e) {
    //     var $content = this.__findDialogContent();
    //
    //     if(this.$node.is(':visible') && $content.has(e.target).length) {
    //         var touches = e.originalEvent.changedTouches;
    //
    //         this.__lastTouchY = touches[0].clientY;
    //     }
    // };
    //
    // this.onBodyTouchMove = function(e) {
    //     var $content = this.__findDialogContent();
    //
    //     if(this.$node.is(':visible')){
    //         e.preventDefault();
    //
    //         if ($content.has(e.target).length) {
    //
    //             var touches = e.originalEvent.changedTouches;
    //
    //             var delta = touches[0].clientY - this.__lastTouchY;
    //             this.__lastTouchY = touches[0].clientY;
    //
    //             $content.get(0).scrollTop += -delta;
    //         }
    //     }
    // };

    this.after('initialize', function () {
        this._initDialog();
        this._onShowWrapper();

        // this.initMobileTouchEndEvent();
    });

    this.before('teardown', function () {
        this.$node.off('dialogopen dialogprepareclose');
        this.$node.dialog('destroy');
        this.dialogEl = null;

        // if (Utility.isMobile()) {
        //     var $body = $('body');
        //
        //     $body.off('touchstart', this.__touchstartWrapper);
        //     $body.off('touchmove', this.__touchmoveWrapper);
        // }
    });
}

module.exports = WithDialog;
