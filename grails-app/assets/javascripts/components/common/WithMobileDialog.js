var flight = require('flight');
var WithDialog = require('./WithDialog');

function WithMobileDialog() {
    flight.compose.mixin(this, [
        WithDialog
    ]);

    this._onShowWrapper = function () {
        if (_.isFunction(this.onShow)) {
            this._customOnShow = this.onShow;
        }

        this.onShow = function (e, data) {
            var $window = $(window);

            this.$node.removeClass('ui-hidden');

            var height = window.innerHeight ? window.innerHeight : $(window).height();

            this.changeSize({
                width: $window.width(),
                height: height
            });

            if (_.isFunction(this._customOnShow)) {
                this._customOnShow.call(this, e, data);
            }

            this.show();
        };
    };

    this.after('initialize', function () {
        this._onShowWrapper();
    });
}

module.exports = WithMobileDialog;
