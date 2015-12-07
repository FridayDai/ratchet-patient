require('../../common/WithDatepicker');

var flight = require('flight');

function DatePicker() {
    this._initDatePicker = function () {
        var me = this;

        this.$node.datepicker({
            dateFormat: 'MM d, yy',
            onSelect: function () {
                this.fixFocusIE = true;

                me.trigger('rc.datePickerSelect');
            }
        });
    };

    this.after('initialize', function () {
        this._initDatePicker();
    });

    this.before('teardown', function () {
        this.$node.datepicker('destroy');
    });
}

module.exports = flight.component(DatePicker);
