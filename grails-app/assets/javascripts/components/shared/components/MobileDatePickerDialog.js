require('../../common/WithDatepicker');

var flight = require('flight');
var WithDialog = require('../../common/WithDialog');

function MobileDatePickerDialog() {
    this.$datePicker = null;
    this.current$elem = null;

    this.options({
        title: 'Add Date',
        width: 440,
        dialogClass: 'mobile-date-picker-dialog mobile-dialog',
        buttons: [{
            text: 'Save',
            click: function () {
                this.selectCurrentDate();
            }
        }]
    });

    this.onShow = function (e, data) {
        this.current$elem = data.$elem;

        if (!this.$datePicker) {
            this.$datePicker = this.$node.find('.inline-date-picker').datepicker({
                dateFormat: 'MM d, yy',
                maxDate: 0,
                changeMonth: this.$node.data('changeMonth'),
                changeYear: this.$node.data('changeYear')
            });
        }

        var currentVal = this.current$elem.val();

        this.$datePicker.datepicker('setDate', currentVal ? currentVal : '0');
    };

    this.selectCurrentDate = function () {
        this.trigger('rc.returnMobileDatePickerValue', {
            $elem: this.current$elem,
            value: this.$datePicker.datepicker().val()
        });

        this.close();
    };
}

module.exports = flight.component(WithDialog, MobileDatePickerDialog);
