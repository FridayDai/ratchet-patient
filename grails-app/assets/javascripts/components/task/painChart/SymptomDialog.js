var flight = require('flight');
var WithDialog = require('../../common/WithDialog');
var Utility = require('../../../utils/Utility');

function SymptomDialog() {
    this.attributes({
        checkBoxGroupSelector: '.msg-center',
        partNameSelector: '#part-name'
    });

    this.options({
        title: 'SELECT SYMPTOMS',
        width: 430,
        buttons: [{
            text: 'Save',
            click: function () {
                this.saveSymptomTags();
            }
        }]

    });

    this.onShow = function (e, data) {
        this.$node.removeClass('ui-hidden');
        this.prepareForShow(data);
        if(Utility.isMobile()) {
            this.changeWidth(320);
        }
        this.show();
    };

    this.prepareForShow = function (data) {
        var checkBoxGroup = this.select('checkBoxGroupSelector');
        checkBoxGroup.find("input:checked").prop('checked', false);
        var resultValue = data.tags;
        if(resultValue) {
            var symptomTags = resultValue.split(',');
            _.forEach(symptomTags, function(ele) {
                var checkbox = "input[value='{0}']".format(ele);
                checkBoxGroup.find(checkbox).prop('checked', true);
            });
        }
        if(data.name) {
            this.select('partNameSelector').text(data.name);
        }
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

