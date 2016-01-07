require('../components/common/initSetup');
require('../components/layout/Main');

var flight = require('flight');
var Task = require('../components/shared/functional/Task');
var SaveComplexDraftAnswer = require('../components/shared/functional/SaveComplexDraftAnswer');
var Utility = require('../utils/Utility');


var ERROR_SCORE_LABEL = '<span class="error-label">This amount entered does not add up to 100%</span>';

function promisTool() {

    this.setSelectErrorStatus = function ($question) {
        if ($question.hasClass('error')) {
            return;
        }

        $question
            .addClass('error')
            .find('.question')
            .append(ERROR_SCORE_LABEL);
    };

    this.checkAllInputValue = function () {
        return this.select('svgResultGroupSelector').find('.active').length > 0;
    };

    this.formSubmit = function (e) {
        var $questionLists = this.select('formSelector').find('.question-list');
        var isValid = true;

        if (Utility.isIE()) {
            this.isFormSubmit = true;
        }

        _.each($questionLists, function (questionEl) {
            var $question = $(questionEl);

            if (!this.isQuestionChecked($question)) {
                this.errorQuestions.push($question);
                this.setErrorStatus($question);

                isValid = false;
            }
        }, this);

        if (!isValid) {
            this.scrollToTopError();
            this.errorQuestions.length = 0;

            e.returnValue = false;
            e.preventDefault();
            return false;
        }

        this.disableSubmitButton();

        this.isFormSubmit = true;
    };

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

            if (checkedChoiceBefore.length === 0) {
                this.clearErrorStatus($target.closest('.question-list'));
            }
        }
    };
}
flight.component(
    Task,
    promisTool
).attachTo('#main');
