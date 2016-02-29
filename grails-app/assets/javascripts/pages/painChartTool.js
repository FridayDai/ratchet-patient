require('../components/common/initSetup');
require('../components/layout/Main');

var flight = require('flight');
var IScroll = require('IScroll');
var WithPage = require('../components/common/WithPage');
var Task = require('../components/shared/functional/Task');
var SaveComplexDraftAnswer = require('../components/shared/functional/SaveComplexDraftAnswer');
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
        painPercentSelector: '#pain-percent-question',
        chartChoicesSelector: '#svg-choice-result input',
        svgResultGroupSelector: '#svg-choice-result'
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
            event: 'showMobileSelectMenuDialog',
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

    this.checkAllInputValue = function () {
        return  this.select('svgResultGroupSelector').find('.active').length > 0;
    };

    this.isSpecialQuestionChecked = function ($question) {
        if($('#no-pain-toggle:checked').length > 0) {
            return true;
        }

        if ($question.data('chart') === true && !this.checkAllInputValue()) {
            this.setErrorStatus($question);
            return false;
        }
        if( $question.data('select') === true && $question.find('#select-percent-score').text().trim() !== "100%") {
            this.setSelectErrorStatus($question);
            return false;
        }
        return true;
    };

    this.iscrollerInRefresh = false;
    this._wantIScrollRefresh = 0;
    this.refreshIScroller = function () {
        var me = this;

        if (this._wantIScrollRefresh === 0) {
            this._wantIScrollRefresh = 1;
        }

        if (this.iscroller && !this.iscrollerInRefresh && this._wantIScrollRefresh === 1) {
            this.iscrollerInRefresh = true;
            setTimeout(function () {
                me.iscroller.refresh();
                me._wantIScrollRefresh = 0;
                me.iscrollerInRefresh = false;
            }, 300);
        }
    };

    this.scrollToTopError = function () {
        var $firstQuestion = this.errorQuestions[0],
            $header = this.select('headerPanelSelector'),
            headerMovedTop = parseInt($header.css('top').replace('px', ''), 10),
            headerHeight = $header.height(),
            visibleHeaderTop = headerHeight + headerMovedTop,
            top,
            $firstError = $firstQuestion;

        if ($firstQuestion.find('.sub-question').length > 0) {
            $firstError = $firstQuestion.find('.error-field:first').closest('.sub-question');
        }

        top = $firstError.offset().top;

        if (!Utility.isMobile()) {
            // If top < 205, than header will show all of it
            if (top - visibleHeaderTop < 205) {
                top -= headerHeight;
            } else {
                top -= visibleHeaderTop;
            }
        }

        if (this.iscroller) {
            this.iscroller.scrollToElement($firstError.get(0), 1000);
        } else {
            window.scrollTo(0, top);
        }
    };

    this.formSubmit = function (e) {
        var $questionLists = this.select('formSelector').find('.question-list');
        var $specialQuestionLists = this.select('formSelector').find('.question-list-special');
        var isValid = true;

        if (Utility.isIE()) {
            this.isFormSubmit = true;
        }

        _.each($specialQuestionLists, function (questionEl) {
            var $question = $(questionEl);

            if (!this.isSpecialQuestionChecked($question)) {
                this.errorQuestions.push($question);
                isValid = false;
            }
        }, this);

        _.each($questionLists, function (questionEl) {
            var $question = $(questionEl);

            if (!this.isQuestionChecked($question)) {
                this.errorQuestions.push($question);
                this.setErrorStatus($question);

                isValid = false;
            }
        }, this);

        if (!isValid) {
            this.refreshIScroller();
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
        var choices = [];
        this.draftAnswer = this.select('formSelector').data('draft') || {};

        if (this.draftAnswer.noPain) {
            this.select('chartChoicesSelector').each(function (index, elem) {
                $(elem).val('');
            });
        } else {
            this.select('chartChoicesSelector').each(function (index, elem) {
                var $elem = $(elem);

                choices.push([$elem.attr('id').replace('-hidden', ''), $elem.val()]);
            });
        }

        this.trigger('initDraftAnswer', {
            chartChoices: choices,
            noPain: this.draftAnswer.noPain,
            draft: this.draftAnswer
        });
    };

    this.prepareDraftAnswer = function ($target) {
        // pain-toggle should trigger in onPainPercentSelectSuccess
        if (!$target.is('.pain-toggle')) {
            var $answer = $target.closest('.answer');
            var $hiddenRadio = $answer.find('.rc-choice-hidden');
            var questionId = $hiddenRadio.attr('name').replace('choices.', '');

            this.draftAnswer[questionId] = $hiddenRadio.val();

            this.saveDraftAnswer();
        }
    };

    this.onSymptomSelectedSuccess = function (e, data) {
        var $hidden = $('#{0}-hidden'.format(data.bodyName));
        var questionId = $hidden.attr('name').replace('choices.', '');

        this.draftAnswer[questionId] = $hidden.val();

        this.saveDraftAnswer();
    };

    this.onPainPercentSelectSuccess = function (e, data) {
        this.draftAnswer[data.question] = data.answer;

        if (data.question === 'noPain' && data.answer === 1) {
            var noPainControl = this.select('formSelector').data('noPainControl');

            for (var i = noPainControl[0]; i < noPainControl[1]; i++) {
                delete this.draftAnswer[i];
            }
        }

        this.saveDraftAnswer();
    };

    this.initIScrollForMobileDialog = function () {
        /*jshint nonew: false */
        if (Utility.isMobile()) {
            this.iscroller = new IScroll('#main', {
                click: true
            });

            this.iscroller.on('beforeScrollStart', function () {
                document.activeElement.blur();
            });

            this.refreshIScroller();
        }
    };

    this.after('initialize', function () {
        this.initDraftAnswer();

        this.on(document, 'symptomSelectedSuccess', this.onSymptomSelectedSuccess);
        this.on(document, 'painPercentSelectSuccess', this.onPainPercentSelectSuccess);

        this.initIScrollForMobileDialog();
        Utility.hideProcessing();

    });
}

flight.component(
    Task,
    WithPage,
    SaveComplexDraftAnswer,
    painChartTask
).attachTo('#main');
