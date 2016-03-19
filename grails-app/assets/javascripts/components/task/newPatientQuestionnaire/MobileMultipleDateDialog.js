var flight = require('flight');
var WithMobileDialog = require('../../common/WithMobileDialog');

function MobileMultipleDateDialog() {
    this.attributes({
        monthSelectSelector: '.month-picker',
        yearSelectSelector: '.year-picker'
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
            this.select('monthSelectSelector')
                .append(data.content.monthOptions)
                .selectmenu();

            this.select('yearSelectSelector')
                .append(data.content.yearOptions)
                .selectmenu();

            var $selectMenuButton = this.$node.find('.ui-selectmenu-button');
            $selectMenuButton.first().addClass('month-picker-selectmenu');
            $selectMenuButton.last().addClass('year-picker-selectmenu');

            this.isInited = true;
        }

        this.current$elem = data.$elem;
    };

    this.saveDate = function () {
        this.trigger('returnMobileMultipleDatePickerValue', {
            $elem: this.current$elem,
            value: '{0}, {1}'.format(this.select('monthSelectSelector').val(), this.select('yearSelectSelector').val())
        });

        this.close();
    };
}

module.exports = flight.component(WithMobileDialog, MobileMultipleDateDialog);
