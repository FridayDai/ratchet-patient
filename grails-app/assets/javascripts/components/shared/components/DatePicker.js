require('../../common/WithDatepicker');

var flight = require('flight');
var Utility = require('../../../utils/Utility');

function DatePicker() {
    this._initDatePicker = function () {
        var me = this;

        this.datePicker = this.$node.datepicker({
            dateFormat: 'MM d, yy',
            beforeShow: function () {
                if (Utility.isMobile()) {
                    me.$node.blur();

                    me.trigger('rc.showMobileDatePickerDialog', {
                        $elem: me.$node
                    });
                    return false;
                }
            },
            onSelect: function (val) {
                this.fixFocusIE = true;

                me.triggerSelectEvent(val);
            }
        });
    };

    this.onMobileDateReturned = function (e, data) {
        if (this.$node.get(0) === data.$elem.get(0)) {
            this.datePicker.datepicker('setDate', data.value);

            this.triggerSelectEvent(data.value);
        }
    };

    this.triggerSelectEvent = function (value) {
        this.trigger('rc.datePickerSelect', {
            $elem: this.$node,
            value: value
        });
    };

    this.after('initialize', function () {
        this._initDatePicker();

        this.on(document, 'rc.returnMobileDatePickerValue', this.onMobileDateReturned);
    });

    this.before('teardown', function () {
        this.$node.datepicker('destroy');
    });
}

module.exports = flight.component(DatePicker);
