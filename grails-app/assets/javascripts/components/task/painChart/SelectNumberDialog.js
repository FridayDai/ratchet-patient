var MobileSelectMenuDialog = require('../../shared/components/MobileSelectMenuDialog');
var Utility = require('../../../utils/Utility');

function SelectNumberDialog() {
    this.attributes({
        checkBoxGroupSelector: '.msg-center'
    });

    this.prepareForShow = function (data) {
        this.selectId = data.id;
        this.select('answerListSelector')
            .find("[type=radio]:checked")
            .prop('checked', false);
        if (Utility.isMobile()) {
            this.setTitle($('#{0}'.format(data.id)).data('title'));
        }

    };

    this.saveNumber = function () {
        var value = this.select('checkBoxGroupSelector').find("input:checked").val() || "0";
        this.trigger('mobileSelectSuccess', {
            id: this.selectId,
            index: value/10,
            label: value
        });
        this.close();
    };
}

module.exports = MobileSelectMenuDialog.mixin(SelectNumberDialog);

