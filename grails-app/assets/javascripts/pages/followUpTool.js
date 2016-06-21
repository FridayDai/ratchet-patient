require('../components/common/initSetup');
require('../components/layout/Main');

var flight = require('flight');
var Task = require('../components/shared/functional/Task');
var SaveComplexDraftAnswer = require('../components/shared/functional/SaveComplexDraftAnswer');

function followUpTool() {
    this.attributes({
        questionListSelector: '.question-list',
        assistToggleSelector: '#assistance-toggle',
        assistValueSelector: '#assistance-toggle-hide',
        textItemSelector: 'textarea'
    });

    this.initDraftAnswer = function () {
        this.draftAnswer = this.select('formSelector').data('draft') || {};
    };

    this.prepareDraftAnswer = function ($target) {
        var $answer = $target.closest('.answer');
        var $hidden = $answer.find('.checkbox-choice-hidden');

        var questionId = $hidden.attr('name').replace('choices.', '');
        this.draftAnswer[questionId] = $hidden.val();

        this.saveDraftAnswer();
    };

    this.onChoiceItemClicked = function (e) {
        e.preventDefault();
        var $target = $(e.target);
        var checkBox = $target.closest(this.attr.choiceItemSelector).find('.rc-choice-hidden');
        var checkValue;

        if (!$target.is('input.rc-choice-hidden')) {
            checkValue = checkBox.prop('checked');
            checkBox.prop('checked', !checkValue);

            this.setTip();

            if (this.select('assistToggleSelector').prop('checked')) {
                this.select('assistValueSelector').val('false');
                this.disableTextarea();
                this.clearErrorStatus($target.closest('.question-list'));
            } else {
                this.enableTextarea();
                this.select('assistValueSelector').val('true');
            }

            this.prepareDraftAnswer($target);
        }
    };

    this.disableTextarea = function () {
        this.select('textItemSelector').prop('disabled', true).hide();
    };

    this.enableTextarea = function () {
        this.select('textItemSelector').prop('disabled', false).show();
    };

    this.onTextInput = function (e) {
        var $target = $(e.target),
            $question = $target.closest('.question-list');

        if ($.trim(this.select('textItemSelector').val())) {
            this.clearErrorStatus($question);
        }
    };

    this.onTextBlur = function (e) {
        var $target = $(e.target);
        var questionId = $target.attr('name').replace('choices.', '');

        this.draftAnswer[questionId] = $target.val();

        this.saveDraftAnswer();
    };

    this.isQuestionChecked = function ($question) {

        var checkbox = $question.find('[type="checkbox"]');
        var textarea = $question.find('textarea');

        return checkbox.prop('checked') || $.trim(textarea.val());
    };

    this.isValid = function () {
        var $question = this.select('formSelector').find('.question-list');
        var isValid = true;

        if (!this.isQuestionChecked($question)) {
            this.errorQuestions.push($question);
            this.setErrorStatus($question);

            isValid = false;
        }

        return isValid;
    };

    this.after('initialize', function () {
        this.initDraftAnswer();
        this.on('input', {
            textItemSelector: this.onTextInput
        });
        this.on('textarea', 'blur', this.onTextBlur);
    });
}

flight.component(
    Task,
    SaveComplexDraftAnswer,
    followUpTool
).attachTo('#main');
