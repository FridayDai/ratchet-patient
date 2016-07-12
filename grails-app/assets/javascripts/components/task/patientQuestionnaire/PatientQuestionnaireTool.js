require('../../common/initSetup');
require('../../layout/Main');
require('velocity');
require('velocity-ui');

var flight = require('flight');
var WithPage = require('../../common/WithPage');
var Task = require('../../shared/functional/Task');
var SaveComplexDraftAnswer = require('../../shared/functional/SaveComplexDraftAnswer');
var ItemTriggerActions = require('./ItemTriggerActions');
var ValidationHandlers = require('./ValidationHandlers');
var DatePicker = require('../../shared/components/DatePicker');
var MobileDatePickerDialog = require('../../shared/components/MobileDatePickerDialog');
var Utility = require('../../../utils/Utility');

var QUESTION_REQUIRE_ERROR_LABEL = '<span class="error-label">This question is required.</span>';
var FIELD_REQUIRE_ERROR_LABEL = '<span class="error-label">Please complete required fields.</span>';

function PatientQuestionnaireTool() {
    flight.compose.mixin(this, [
        Task,
        WithPage,
        ItemTriggerActions,
        ValidationHandlers,
        SaveComplexDraftAnswer
    ]);

    this.attributes({
        startQuestionValidation: false,

        textItemSelector: '.specify-input, textarea',
        choiceItemSelector: '.answer, .sub-question-answer',
        datePickerSelector: '.date-picker',
        mobileDatePickerDialogSelector: '#mobile-date-picker-dialog'
    });

    this.children({
        datePickerSelector: {
            child: DatePicker,
            attributes: {
                maxDate: 0,
                changeMonth: true,
                changeYear: true
            }
        }
    });

    this.dialogs([
        {
            selector: 'mobileDatePickerDialogSelector',
            event: 'rc.showMobileDatePickerDialog',
            dialog: MobileDatePickerDialog
        }
    ]);

    this.onTextInput = function (e) {
        var $target = $(e.target),
            $question = $target.closest('.question-list');

        this.validateQuestion($question);
    };

    this.onChoiceItemClicked = function (e) {
        e.preventDefault();
        e.stopPropagation();

        var $target = $(e.target),
            $choiceItem = $target.closest(this.attr.choiceItemSelector);

        if (!$target.is('input.rc-choice-hidden')) {
            $choiceItem
                .find('[type="radio"].rc-choice-hidden')
                .prop('checked', true);

            var $checkbox = $choiceItem.find('[type="checkbox"].rc-choice-hidden');
            if ($checkbox.length > 0) {
                $checkbox
                    .each(function (index, elem) {
                        var $elem = $(elem);

                        $elem.prop('checked', !$elem.prop('checked'));
                    });
            }

            this.checkTriggerTarget($choiceItem);

            var $question = $target.closest('.question-list');

            this.validateQuestion($question);

            this.saveDraftForChoiceItem($target);
        }
    };

    this.onDatePickerSelected = function (e, data) {
        var $question = data.$elem.closest('.question-list');
        var $answer = data.$elem.closest(this.attr.choiceItemSelector);
        var $hiddenRadio = $answer.find('.rc-choice-hidden');
        var questionId = data.$elem.attr('name').replace('choices.', '');

        if ($hiddenRadio.length > 0 && !$hiddenRadio.prop('checked')) {
            $hiddenRadio.prop('checked', true);

            var hiddenQuestionId = $hiddenRadio.attr('name').replace('choices.', '');

            this.draftAnswer[hiddenQuestionId] = $hiddenRadio.val();
        }

        this.validateQuestion($question);

        this.draftAnswer[questionId] = data.value;

        this.saveDraftAnswer();
    };

    this.validateQuestion = function ($question) {
        if (this.checkQuestionValidation($question, this.VALIDATION['#' + $question.attr('id')])) {
            this.clearErrorStatus($question);
        } else {
            this.setErrorStatus($question);
        }
    };

    this.checkTriggerTarget = function ($item) {
        var triggerData = $item.data('trigger');

        if (!triggerData) {
            return;
        }

        _.each(triggerData, function (actions, target) {
            var $target = $(target);

            _.each(actions.split('|'), function (action) {
                this.runTriggerAction($target, action, $item);
            }, this);
        }, this);
    };

    this.runTriggerAction = function ($target, action, $currentItem) {
        this['trigger{0}Action'.format(_.capitalize(action))].call(this, $target, $currentItem);
    };

    this.setErrorStatus = function ($question) {
        if(!$question.hasClass('error')) {
            $question.addClass('error');
        }

        $question
            .find('.error-label')
            .remove();

        var $title = $question.find('.question');

        if ($question.data('questionRequiredValid')) {
            $title.append(FIELD_REQUIRE_ERROR_LABEL);
        } else {
            $title.append(QUESTION_REQUIRE_ERROR_LABEL);
        }
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

    this.isValid = function () {
        var isValid = true;

        this.attr.startQuestionValidation = true;

        _.each(this.VALIDATION, function (condition, questionSelector) {
            var $question = $(questionSelector);

            if (!this.checkQuestionValidation($question, condition)) {
                this.errorQuestions.push($question);
                this.setErrorStatus($question);

                isValid = false;
            }
        }, this);

        return isValid;
    };

    this.checkQuestionValidation = function ($question, condition) {
        if (!condition || !this.attr.startQuestionValidation) {
            return true;
        }

        var required = condition.required;
        var requiredValid = true;

        if (required) {
            Utility.checkArraySelfRun(required, function (selector) {
                if (!this.checkItemValid($question, selector)) {
                    requiredValid = false;
                }
            }, this);
        }

        $question.data('questionRequiredValid', requiredValid);

        var depends = condition.depends;
        var dependsValid = true;

        if (requiredValid) {
            if (required) {
                this.clearRequiredItemError($question, required);
            }

            _.each(depends, function (items, dependOn) {
                if (!this.checkDependOnTurnOn($question, dependOn)) {
                    Utility.checkArraySelfRun(items, function (item) {
                        this.clearItemError($question, item);
                    }, this);

                    return;
                }

                Utility.checkArraySelfRun(items, function (item) {
                    this.clearItemError($question, item);

                    if (!this.checkItemValid($question, item)) {
                        dependsValid = false;
                    }
                }, this);
            }, this);
        }

        return requiredValid && dependsValid;
    };

    this.getTypeAndSelector = function (str) {
        var regexp = /(.*):(.*)/,
            arr = str.match(regexp),
            type = arr[1],
            selector = arr[2];

        return {
            type: type,
            selector: selector
        };
    };

    this.checkItemValid = function ($parent, str) {
        var typeSelector = this.getTypeAndSelector(str),
            $item = $parent.find(typeSelector.selector);

        if ($item.prop('disabled')) {
            return true;
        }

        return this['check{0}Valid'.format(_.capitalize(typeSelector.type))].call(this, $item);
    };

    this.clearItemError = function ($question, str) {
        var typeSelector = this.getTypeAndSelector(str),
            $item = $question.find(typeSelector.selector);

        this['clear{0}Error'.format(_.capitalize(typeSelector.type))].call(this, $item);
    };

    this.checkDependOnTurnOn = function ($question, dependOn) {
        var typeSelector = this.getTypeAndSelector(dependOn),
            $item = $question.find(typeSelector.selector);

        switch (typeSelector.type) {
            case 'radio':
                return $item.filter(':checked').length > 0;

            case 'group':
                return true;

            case 'text':
            case 'textarea':
                return !!$item.val();
        }
    };

    this.clearRequiredItemError = function ($question, requiredSelector) {
        Utility.checkArraySelfRun(requiredSelector, function (str) {
            var typeSelector = this.getTypeAndSelector(str),
                $item = $question.find(typeSelector.selector);

            switch (typeSelector.type) {
                case 'text':
                case 'textarea':
                    $item.removeClass('error-field');
                    break;

                case 'radio':
                    $item
                        .next()
                        .removeClass('error-field');
                    break;
            }
        }, this);
    };

    this.onTextBlur = function (e) {
        var $target = $(e.target);
        var questionId = $target.attr('name').replace('choices.', '');

        this.draftAnswer[questionId] = $target.val();

        this.saveDraftAnswer();
    };

    this.initDraftAnswer = function () {
        this.draftAnswer = this.select('formSelector').data('draft') || {};
    };

    this.saveDraftForChoiceItem = function ($target) {
        var $answer = $target.closest(this.attr.choiceItemSelector);
        var $hiddenRadio = $answer.find('.rc-choice-hidden');
        var questionId = $hiddenRadio.attr('name').replace('choices.', '');

        if ($hiddenRadio.is('[type=radio]')) {
            this.draftAnswer[questionId] = $hiddenRadio.val();
        } else if ($hiddenRadio.is('[type=checkbox]')) {
            this.draftAnswer[questionId] =
                _.reduce($('[name="{0}"]:checked'.format($hiddenRadio.attr('name'))), function (result, elem) {
                    result.push($(elem).val());

                    return result;
                }, []).join(',');
        }

        this.saveDraftAnswer();
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

        window.scrollTo(0, top);
    };

    this.after('initialize', function () {
        this.initDraftAnswer();

        this.on(document, 'rc.datePickerSelect', this.onDatePickerSelected);

        this.on('input', {
            textItemSelector: this.onTextInput
        });

        this.on('.specify-input, textarea', 'blur', this.onTextBlur);
        
        Utility.hideProcessing();
    });
}

module.exports = PatientQuestionnaireTool;
