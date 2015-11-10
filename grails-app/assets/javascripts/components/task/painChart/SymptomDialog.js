var flight = require('flight');
var WithDialog = require('../../common/WithDialog');

function SymptomDialog() {
    this.attributes({
        checkBoxGroupSelector: '.msg-center'
    });

    this.options({
        title: 'SELECT SYMPTOMS',
        width: 500,
        buttons: [{
            text: 'Save',
            click: function () {
                this.saveSymptomTags();
            }
        }]

    });

    this.onShow = function () {
        this.$node.removeClass('ui-hidden');
        this.show();
    };

    this.saveSymptomTags = function () {
        var symptomsTags = [];
        var checkBox = this.select('checkBoxGroupSelector').find("input:checked");
        checkBox.each(function () {
            symptomsTags[symptomsTags.length] = $(this).val();
        });
        this.trigger('symptomSelectedSuccess', {tags: symptomsTags});
        this.close();
    };

    this.after('initialize', function () {

    });


}

module.exports = flight.component(WithDialog, SymptomDialog);

