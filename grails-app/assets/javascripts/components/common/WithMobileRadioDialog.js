var flight = require('flight');
var WithDialog = require('./WithDialog');

function WithMobileRadioDialog() {
    flight.compose.mixin(this, [
        WithDialog
    ]);

    this.attributes({
        choiceItemSelector: '.answer'
    });

    this.onChoiceItemClicked = function (e) {
        var $target = $(e.target),
            $choiceItem = $target.closest(this.attr.choiceItemSelector);

        if (!$target.is('input.rc-choice-hidden')) {
            $choiceItem
                .find('[type="radio"].rc-choice-hidden')
                .prop('checked', true);
        }
    };

    this.after('initialize', function () {
        this.on('click', {
            choiceItemSelector: this.onChoiceItemClicked
        });
    });
}

module.exports = WithMobileRadioDialog;
