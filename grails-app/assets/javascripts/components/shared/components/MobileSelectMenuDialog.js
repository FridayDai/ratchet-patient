var flight = require('flight');
var WithMobileRadioDialog = require('../../common/WithMobileRadioDialog');

function MobileSelectMenuDialog() {
    this.attributes({
        answerListSelector: '.answer-list'
    });

    this.setOptions = function () {
        return {
            title: this.$node.data('title'),
            dialogClass: 'mobile-dialog',
            width: 320,
            buttons: [{
                text: 'Save',
                click: function () {
                    this.saveNumber();
                }
            }]
        };
    };

    this.onShow = function (e, data) {
        this.prepareForShow(data);
    };

    this.prepareForShow = function (data) {
        this.selectId = data.id;
        this.select('answerListSelector')
            .find("[type=radio]:checked")
            .prop('checked', false);
    };

    this.saveNumber = function () {
        var $checked = this.select('answerListSelector').find("[type=radio]:checked");

        if ($checked.length === 0) {
            return false;
        }

        var label = $checked.closest('.answer').find('.text').text();
        var value = $checked.val() || "0";
        var index = $checked.data('index');

        this.trigger('mobileSelectSuccess', {
            id: this.selectId,
            index: index,
            label: label,
            value: value
        });

        this.close();
    };
}

module.exports = flight.component(WithMobileRadioDialog, MobileSelectMenuDialog);
