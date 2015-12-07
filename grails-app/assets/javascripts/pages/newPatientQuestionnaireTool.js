require('../components/common/initSetup');
require('../components/layout/Main');
require('velocity');
require('velocity-ui');
require('../libs/MobileSelectMenu');

var flight = require('flight');
var WithChildren = require('../components/common/WithChildren');
var Task = require('../components/shared/functional/Task');
var DatePicker = require('../components/shared/components/DatePicker');
var MultipleDatePicker = require('../components/shared/components/MultipleDatePicker');
var Utility = require('../utils/Utility');

var DEFAULT_TEXT_PICK_TIME = '<span class="select-menu-default-text">Pick Time</span>';

var QUESTION_REQUIRE_ERROR_LABEL = '<span class="error-label">This question is required.</span>';
var FIELD_REQUIRE_ERROR_LABEL = '<span class="error-label">Complete required fields</span>';

function newPatientQuestionnaireTool() {

    this.attributes({
        needClearInputAnswerSelector: '.question-1 .answer, .question-3 .answer, .need-clear-inputs',
        choiceItemSelector: '.answer, .sub-question-answer',
        extensionTriggerYesSelector: '.answer-extension-trigger-yes',
        extensionTriggerNoSelector: '.answer-extension-trigger-no',
        selectMenuSelector: '.select-menu',
        question12NoChangeSelector: '.question-12-no-change',
        question12HasChangeSelector: '.question-12-has-change',
        accidentInjuryYesSelector: '#accidentInjuryYes',
        accidentInjuryNoSelector: '#accidentInjuryNo',
        accidentInjuryQuestionSelector: '#accidentInjuryQuestion',
        datePickerSelector: '.date-picker',
        multipleDatePickerSelector: '.multi-date-container'
    });

    this.children({
        datePickerSelector: DatePicker,
        multipleDatePickerSelector: MultipleDatePicker
    });

    this.onExtensionTriggerYesClicked = function (e) {
        var $target = $(e.target);
        var $extension = $target.closest('.answer-list').find('.extension-question-list');

        if (!$target.is('input.rc-choice-hidden')) {
            if (!$extension.is(':visible')) {
                this.toggleExtension($extension, true);
            }
        }
    };

    this.onExtensionTriggerNoClicked = function (e) {
        var $target = $(e.target);
        var $extension = $target.closest('.answer-list').find('.extension-question-list');

        if (!$target.is('input.rc-choice-hidden')) {
            if ($extension.is(':visible')) {
                this.toggleExtension($extension, false);
                $extension
                    .find('input[type="text"], textarea')
                    .val('')
                    .end()
                    .find('input[type="radio"]')
                    .prop('checked', false);
            }
        }
    };

    this.toggleExtension = function ($target, letShow) {
        if (letShow) {
            $target.velocity('transition.slideDownIn');
        } else {
            $target.velocity('transition.slideUpOut');
        }
    };

    this.initSelectMenu = function () {
        var self = this;

        this.select('selectMenuSelector').selectmenu({
            width: 200,
            defaultButtonText: DEFAULT_TEXT_PICK_TIME,
            select: function (e, ui) {
                //self.sumScore();
                //
                //self.triggerPainPercentSelectSuccess(
                //    $(this).attr('name').replace('choices.', ''),
                //    ui.item.value
                //);
            }
        });
    };

    this.onQuestion12NoChangeClicked = function (e) {
        this.toggleQuestion12TimePicker(e, true);
    };

    this.onQuestion12HasChangeClicked = function (e) {
        this.toggleQuestion12TimePicker(e, false);
    };

    this.toggleQuestion12TimePicker = function (e, letDisable) {
        var $target = $(e.target);
        var $subQuestion = $target.closest('.sub-question');

        if (!$target.is('input.rc-choice-hidden')) {
            $subQuestion.find('select').selectmenu('option', 'disabled', letDisable);

            if (letDisable) {
                $subQuestion.find('select').selectmenu('option', 'defaultButtonText', DEFAULT_TEXT_PICK_TIME).val(0);
            }
        }
    };

    this.onAccidentInjuryYesClicked = function (e) {
        var $target = $(e.target);
        var $question = this.select('accidentInjuryQuestionSelector');
        var $textarea = $question.find('textarea');

        if (!$target.is('input.rc-choice-hidden')) {
            $question.removeClass('disabled');
            $textarea.prop('disabled', false);
        }
    };

    this.onAccidentInjuryNoClicked = function (e) {
        var $target = $(e.target);
        var $question = this.select('accidentInjuryQuestionSelector');
        var $textarea = $question.find('textarea');

        if (!$target.is('input.rc-choice-hidden')) {
            if (!$question.hasClass('disabled')) {
                $question.addClass('disabled');

                $textarea
                    .val('')
                    .prop('disabled', true);
            }
        }
    };

    this.whenAnswerClickClearInputs = function (e) {
        var $target = $(e.target);
        var $currentAnswer = $target.closest('.answer');
        var $answerList = $target.closest('ul');
        var $inputs = $answerList.find('input[type="text"]');

        if (!$target.is('input.rc-choice-hidden')) {
            _.each($inputs, function (elem) {
                if ($currentAnswer.has(elem).length === 0) {
                    $(elem).val('');
                }
            });
        }
    };

    this.setErrorStatus = function ($question, errMsg) {
        if ($question.hasClass('error')) {
            return;
        }

        $question
            .addClass('error')
            .find('.question')
            .append(errMsg);
    };

    this.clearErrorStatus = function ($question) {
        $question = $($question);

        if ($question.hasClass('error')) {
            $question
                .removeClass('error')
                .find('.error-label')
                .remove();
        }
    };

    this.getInvalidField = function ($question) {
        if ($question.data('optional') === true) {
            return null;
        }

        var $radios = $question.find('[type="radio"]');
        var $checked = $radios.filter(':checked');
        var $requiredInput;

        if ($checked.length === 0) {
            $radios.next().addClass('error-field');
            this.setErrorStatus($question, QUESTION_REQUIRE_ERROR_LABEL);
            return false;
        } else {
            $requiredInput = $checked.closest('.answer').find('input');

            if (!$requiredInput.val()) {
                $requiredInput.addClass('error-field');
                this.setErrorStatus($question, FIELD_REQUIRE_ERROR_LABEL);
                return false;
            }
        }

        return true;
    };

    this.isValid = function () {
        var $questionLists = this.select('formSelector').find('.question-list');
        var isValid = true;

        _.each($questionLists, function (questionEl) {
            var $question = $(questionEl);

            if (!this.isQuestionValid($question)) {
                this.errorQuestions.push($question);
                this.setErrorStatus($question);

                isValid = false;
            }
        }, this);

        return isValid;
    };

    this.after('initialize', function () {
        this.initSelectMenu();

        this.on('click', {
            extensionTriggerYesSelector: this.onExtensionTriggerYesClicked,
            extensionTriggerNoSelector: this.onExtensionTriggerNoClicked,
            question12NoChangeSelector: this.onQuestion12NoChangeClicked,
            question12HasChangeSelector: this.onQuestion12HasChangeClicked,
            accidentInjuryYesSelector: this.onAccidentInjuryYesClicked,
            accidentInjuryNoSelector: this.onAccidentInjuryNoClicked,
            needClearInputAnswerSelector: this.whenAnswerClickClearInputs
        });

        Utility.hideProcessing();
    });
}

flight.component(
    WithChildren,
    Task,
    newPatientQuestionnaireTool
).attachTo('#main');
