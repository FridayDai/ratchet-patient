var flight = require('flight');
var WithMobileDialog = require('../../common/WithMobileDialog');
var Utility = require('../../../utils/Utility');

function SymptomDialog() {
    this.attributes({
        checkBoxGroupSelector: '.msg-center',
        partNameSelector: '#part-name',
        choiceItemSelector: '.answer'
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

        if (resultValue) {
            var symptomTags = resultValue.split(',');
            _.forEach(symptomTags, function (ele) {
                var checkbox = "input[value='{0}']".format(ele);
                checkBoxGroup.find(checkbox).prop('checked', true);
            });
        }

        if (bodyName) {
            this.select('partNameSelector').text(bodyName.replace(/-/g, ' '));
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

    this._onShowWrapper = function () {
        if (_.isFunction(this.onShow)) {
            this._customOnShow = this.onShow;
        }

        this.onShow = function (e, data) {
            var $window = $(window);

            this.$node.removeClass('ui-hidden');

            var height = window.innerHeight ? window.innerHeight : $(window).height();

            if (Utility.isMobile()) {
                this.changeSize({
                    width: $window.width(),
                    height: height
                });
            } else {
                this.changeSize({
                    height: 'auto'
                });
            }

            this.prepareForShow(data);
            this.show();
        };
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

module.exports = flight.component(WithMobileDialog, SymptomDialog);

