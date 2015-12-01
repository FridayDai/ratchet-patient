require('../components/common/initSetup');
require('../components/layout/Main');

var flight = require('flight');
var WithPage = require('../components/common/WithPage');
var Task = require('../components/shared/functional/Task');
var Utility = require('../utils/Utility');
var ChartPanel = require('../components/task/painChart/PainDrawingBoard');
var SymptomDialog = require('../components/task/painChart/SymptomDialog');
var NumberDialog = require('../components/task/painChart/SelectNumberDialog');
var PainPercentPanel = require('../components/task/painChart/PainPercentPanel');

var ERROR_SCORE_LABEL = '<span class="error-label">This amount entered does not add up to 100%</span>';

function painChartTask() {

    this.attributes({
        chartPanelSelector: '#pain-drawing-board',
        symptomDialogSelector: '#symptom-choice-dialog',
        numberDialogSelector: '#number-mobile-dialog',
        painPercentSelector: '#pain-percent-question'
    });

    this.children({
        chartPanelSelector: ChartPanel,
        painPercentSelector: PainPercentPanel
    });

    this.dialogs([
        {
            selector: 'symptomDialogSelector',
            event: 'showSymptomDialog',
            dialog: SymptomDialog
        },
        {
            selector: 'numberDialogSelector',
            event: 'showMobileNumberDialog',
            dialog: NumberDialog
        }
    ]);

    this.setSelectErrorStatus = function ($question) {
        if ($question.hasClass('error')) {
            return;
        }

        $question
            .addClass('error')
            .find('.question')
            .append(ERROR_SCORE_LABEL);
    };

    this.isSelectScoreChecked = function ($question) {
        if ($question.data('optional') === true || $question.find('#no-pain-toggle:checked').length > 0) {
            return true;
        }

        var score = $question.find('#select-percent-score').text().trim();
        return +score === 100;
    };

    this.formSubmit = function () {
        var $questionLists = this.select('formSelector').find('.question-list');
        var $specialQuestionLists = this.select('formSelector').find('.question-list-special');
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

        _.each($specialQuestionLists, function (questionEl) {
            var $question = $(questionEl);

            if (!this.isSelectScoreChecked($question)) {
                this.errorQuestions.push($question);
                this.setSelectErrorStatus($question);

                isValid = false;
            }
        }, this);

        if (!isValid) {
            this.scrollToTopError();
            this.errorQuestions.length = 0;

            event.returnValue = false;
            return false;
        }

        this.disableSubmitButton();

        this.isFormSubmit = true;
    };


}
flight.component(Task, WithPage, painChartTask).attachTo('#main');
