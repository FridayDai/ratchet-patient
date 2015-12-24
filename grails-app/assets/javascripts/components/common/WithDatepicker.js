require('jquery-ui-datepicker');

var Utility = require('../../utils/Utility');

$.datepicker.setDefaults({
    /* fix buggy IE focus functionality */
    fixFocusIE: false,

    /* blur needed to correctly handle placeholder text */
    onClose: function () {
        this.fixFocusIE = true;
    },

    beforeShow: function () {
        var result = Utility.isOldIE() ? !this.fixFocusIE : true;
        this.fixFocusIE = false;
        return result;
    }
});
