var flight = require('flight');
var WithDialog = require('../../common/WithDialog');

function SymptomDialog() {
    this.attributes({
        checkBoxGroupSelector: '.msg-center',
        partNameSelector: '#part-name',
        partDirectionSelector: '#part-direction',
        choiceItemSelector: '.ui-dialog .answer'
    });

    this.options({
        title: 'PAIN SYMPTOMS',
        width: 440,
        buttons: [{
            text: 'Save',
            click: function () {
                this.saveSymptomTags();
            }
        }]
    });

    this.prepareForShow = function (data) {
        var checkBoxGroup = this.select('checkBoxGroupSelector');
        checkBoxGroup.find("input:checked").prop('checked', false);
        var resultValue = data.tags;
        var bodyName = this.bodyName = data.bodyName;
        var direction;

        if (resultValue) {
            var symptomTags = resultValue.split(',');
            _.forEach(symptomTags, function (ele) {
                var checkbox = "input[value='{0}']".format(ele);
                checkBoxGroup.find(checkbox).prop('checked', true);
            });
        }

        if (bodyName) {
            direction = bodyName.match(/^\w+/);
            direction = direction ? direction[0] : '';

            if(direction === 'Middle') {
                this.select('partDirectionSelector').hide();
            } else {
                this.select('partDirectionSelector').show()
                    .removeClass('Left').removeClass('Right')
                    .addClass(direction).text(direction);
            }

            this.select('partNameSelector').text(bodyName.replace(/(?:\w+)-(\w+)-?(\w*)/, "$1 $2"));
        }
    };

    this.saveSymptomTags = function () {
        var symptomsTags = [];
        var checkBox = this.select('checkBoxGroupSelector').find("input:checked");

        checkBox.each(function () {
            symptomsTags[symptomsTags.length] = $(this).val();
        });

        this.trigger('symptomSelectedSuccess', {
            tags: symptomsTags,
            bodyName: this.bodyName
        });
        this.close();
    };

    this.onShow = function (e, data) {
        this.prepareForShow(data);
    };

    this.onChoiceItemClicked = function (e) {
        var $target = $(e.target),
            $choiceItem = $target.closest(this.attr.choiceItemSelector);
        var checkBox = $choiceItem.find('[type="checkbox"].rc-choice-hidden');
        var checked = checkBox.prop('checked');

        checkBox.prop('checked', !checked);

    };

    this.after('initialize', function () {
        this.on(this.attr.choiceItemSelector, 'click', {
            choiceItemSelector: this.onChoiceItemClicked
        });
    });
}

module.exports = flight.component(WithDialog, SymptomDialog);

