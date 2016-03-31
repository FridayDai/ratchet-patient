var flight = require('flight');
var WithMobileDialog = require('../../common/WithMobileDialog');
var MonthYearPicker = require('../../shared/components/MonthYearPicker');

function MobileMultipleDateDialog() {
    this.attributes({
        monthYearPickerSelector: '.picker-container'
    });

    this.setOptions = function () {
        return {
            title: this.$node.data('title'),
            dialogClass: 'mobile-dialog mobile-multiple-date-picker',
            width: 320,
            buttons: [{
                text: 'Ok',
                click: function () {
                    this.saveDate();
                }
            }]
        };
    };

    this.onShow = function (e, data) {
        this.prepareForShow(data);
    };

    this.isInited = false;
    this.prepareForShow = function (data) {
        if (!this.isInited) {
            this.monthYearPicker = MonthYearPicker.attachTo(this.attr.monthYearPickerSelector);

            this.isInited = true;
        }
        this.current$elem = data.$elem;
    };

    this.saveDate = function () {
        this.trigger('returnMobileMultipleDatePickerValue', {
            $elem: this.current$elem,
            value: this.monthYearPicker.val()
        });

        this.close();
    };
}

module.exports = flight.component(
    WithMobileDialog,
    MobileMultipleDateDialog
);
