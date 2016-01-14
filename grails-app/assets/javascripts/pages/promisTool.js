require('../components/common/initSetup');
require('../components/layout/Main');

var flight = require('flight');
var Task = require('../components/shared/functional/Task');

function promis() {
    this.onChoiceItemClicked = function (e) {
        var $target = $(e.target);
        var checkedChoiceBefore = $target
            .closest('.answer-list')
            .find('[type="radio"].rc-choice-hidden:checked');

        if (!$target.is('input.rc-choice-hidden')) {
            $target.closest(this.attr.choiceItemSelector)
                .find('.rc-choice-hidden')
                .prop('checked', true);

            this.prepareDraftAnswer($target);

            if(checkedChoiceBefore.length === 0) {
                this.clearErrorStatus($target.closest('.question-list'));
            }
        }
    };
}

flight.component(Task,promis).attachTo('#main');
