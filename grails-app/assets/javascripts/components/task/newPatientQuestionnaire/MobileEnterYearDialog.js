var MobileSelectMenuDialog = require('../../shared/components/MobileSelectMenuDialog');

function MobileEnterYearDialog() {
    this.saveNumber = function () {
        var $checked = this.select('answerListSelector').find("[type=radio]:checked");

        if ($checked.length === 0) {
            return false;
        }

        var label = $checked.closest('.answer').find('.text').text().replace(/\syears?/, '');
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

module.exports = MobileSelectMenuDialog.mixin(MobileEnterYearDialog);
