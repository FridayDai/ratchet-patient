require('../components/common/initSetup');
require('../components/layout/Main');

var flight = require('flight');
var WithPage = require('../components/common/WithPage');
var Task = require('../components/shared/functional/Task');
var ChartPanel = require('../components/task/painChart/HumanSvg');
var SymptomDialog = require('../components/task/painChart/SymptomDialog');
var NumberDialog = require('../components/task/painChart/SelectNumberDialog');
var PainPercentPanel = require('../components/task/painChart/PainPercentPanel');

var ERROR_SCORE_LABEL = '<span class="error-label">This amount entered does not add up to 100%</span>';

function painChartTask() {

    this.attributes({
        chartPanelSelector: '#draw-board',
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

    this.specialQuestionsValid = function (questionEl) {
        var $question = $(questionEl);

        if (!this.isSelectScoreChecked($question)) {
            this.errorQuestions.push($question);
            this.setSelectErrorStatus($question);

            isValid = false;
        }
    }


}
flight.component(Task, WithPage, painChartTask).attachTo('#main');
