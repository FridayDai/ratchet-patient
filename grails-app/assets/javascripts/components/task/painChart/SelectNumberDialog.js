var MobileSelectMenuDialog = require('../../shared/components/MobileSelectMenuDialog');

function SelectNumberDialog() {
    this.attributes({
        checkBoxGroupSelector: '.msg-center'
    });

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

