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
        return  this.select('svgResultGroupSelector').find('.active').length > 0;
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

    this.initDraftAnswer = function () {
        this.draftAnswer = this.select('formSelector').data('draft') || {};
    };

    this.prepareDraftAnswer = function ($target) {
        var $questionList = $target.closest('.question-list');
        var $answer = $target.closest('.answer');
        var $hiddenRadio = $answer.find('.rc-choice-hidden');
        var index = $questionList.data('index');

        this.draftAnswer[index] = $hiddenRadio.val();

        this.saveDraftAnswer();
    };

    this.after('initialize', function () {
        this.initDraftAnswer();

        Utility.hideProcessing();
    });
}

flight.component(
    Task,
    SaveComplexDraftAnswer,
    promisTool
).attachTo('#main');
