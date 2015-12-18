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

var QUESTION_12_VALIDATION = {};
for (var i = 0; i < 9; i++) {
    QUESTION_12_VALIDATION['group:{0}'.format(i)] = [
        'radio:[name="choices.12.{0}.c"]'.format(i),
        'select:[name="choices.12.{0}.s"]'.format(i)
    ];
}

var VALIDATION = {
    '#question1': {
        required: 'radio:[name="choices.1.c"]',
        depends: {
            'radio:[name="choices.1.c"][value=1]': 'text:[name="choices.1.1s"]',
            'radio:[name="choices.1.c"][value=3]': 'text:[name="choices.1.3s"]',
            'radio:[name="choices.1.c"][value=5]': 'text:[name="choices.1.5s"]'
        }
    },
    '#question2': {
        required: 'radio:[name="choices.2"]'
    },
    '#question3': {
        required: 'radio:[name="choices.3.c"]',
        depends: {
            'radio:[name="choices.3.c"][value=6]': 'text:[name="choices.3.6s"]'
        }
    },
    '#question4': {
        required: 'textarea:[name="choices.4"]'
    },
    '#question5': {
        required: 'radio:[name="choices.5"]'
    },
    '#question6': {
        required: 'radio:[name="choices.6"]'
    },
    '#question7': {
        required: 'radio:[name="choices.7.c"]',
        depends: {
            'radio:[name="choices.7.c"][value=1]': 'text:[name="choices.7.1s"]'
        }
    },
    '#question8': {
        required: 'radio:[name="choices.8"]'
    },
    '#question9': {
        required: 'radio:[name="choices.9.c"]',
        depends: {
            'radio:[name="choices.9.c"][value=1]': [
                'text:[name="choices.9.e.1"]',
                'textarea:[name="choices.9.e.2"]',
                'textarea:[name="choices.9.e.3"]',
                'radio:[name="choices.9.e.4"]:checked',
                'text:[name="choices.9.e.5"]',
                'radio:[name="choices.9.e.7.c"]'
            ],
            'radio:[name="choices.9.e.7.c"][value=1]': 'text:[name="choices.9.e.7.1s"]'
        }
    },
    '#question10': {
        required: 'radio:[name="choices.10.c"]',
        depends: {
            'radio:[name="choices.10.c"][value=1]': [
                'text:[name="choices.10.1s"]',
                'radio:[name="choices.10.e.1.c"]',
                'radio:[name="choices.10.e.2.c"]'
            ],
            'radio:[name="choices.10.e.1.c"][value=1]': 'text:[name="choices.10.e.1.1s"]',
            'radio:[name="choices.10.e.2.c"][value=1]': [
                'text:[name="choices.10.e.2.1s"]',
                'text:[name="choices.10.e.3"]'
            ]
        }
    },
    '#question11': {
        required: 'radio:[name="choices.11.c"]',
        depends: {
            'radio:[name="choices.11.c"][value=1]': [
                'text:[name="choices.11.1s"]',
                'textarea:[name="choices.11.e.1"]'
            ]
        }
    },
    '#question12': {
        depends: QUESTION_12_VALIDATION
    }
};

function newPatientQuestionnaireTool() {
    this.attributes({
        textItemSelector: '[type=text],textarea',
        choiceItemSelector: '.answer, .sub-question-answer',
        selectMenuSelector: '.select-menu',
        datePickerSelector: '.date-picker',
        multipleDatePickerSelector: '.multi-date-container'
    });

    this.children({
        datePickerSelector: DatePicker,
        multipleDatePickerSelector: MultipleDatePicker
    });

    this.onTextInput = function (e) {
        var $target = $(e.target),
            $question = $target.closest('.question-list');

        this.validateQuestion($question);
    };

    this.onChoiceItemClicked = function (e) {
        var $target = $(e.target),
            $choiceItem = $target.closest(this.attr.choiceItemSelector);

        if (!$target.is('input.rc-choice-hidden')) {
            $choiceItem
                .find('[type="radio"].rc-choice-hidden')
                .prop('checked', true);

            this.checkTriggerTarget($choiceItem);

            //this.clearErrorStatus($target.closest('.question-list'));
            var $question = $target.closest('.question-list');

            this.validateQuestion($question);

            //this.prepareDraftAnswer($target);
        }
    };

    this.validateQuestion = function ($question) {
        if (this.checkQuestionValidation($question, VALIDATION['#' + $question.attr('id')])) {
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
        switch (action) {
            case 'show' :
                if (!$target.is(':visible')) {
                    $target.velocity('transition.slideDownIn');
                }
                break;

            case 'hide':
                if ($target.is(':visible')) {
                    $target.velocity('transition.slideUpOut');
                }
                break;

            case 'enable':
                if ($target.is('select')) {
                    $target.selectmenu('option', 'disabled', false);
                } else if ($target.is('[type=text], textarea')) {
                    $target.prop('disabled', false);
                } else {
                    $target.removeClass('disabled')
                        .find('[type=text], textarea')
                        .prop('disabled', false);
                }
                break;

            case 'disable':
                if ($target.is('select')) {
                    $target
                        .selectmenu('option', 'disabled', true)
                        .selectmenu('option', 'defaultButtonText', DEFAULT_TEXT_PICK_TIME)
                        .val(0);
                } else if ($target.is('[type=text], textarea')) {
                    $target.prop('disabled', true);
                } else {
                    $target.addClass('disabled')
                        .find('[type=text], textarea')
                        .prop('disabled', true);
                }
                break;

            case 'clearOtherInputs':
                if ($target.length > 0) {
                    _.each($target, function (elem) {
                        if ($currentItem.has(elem).length === 0) {
                            $(elem).val('');
                        }
                    });
                } else {
                    $target.val('');
                }
                break;

            case 'reset':
                if ($target.length > 0) {
                    _.each($target, function (elem) {
                        this.resetElement($(elem));
                    }, this);
                } else {
                    this.resetElement($target);
                }
                break;
        }
    };

    this.resetElement = function ($elem) {
        if ($elem.hasClass('disabled')) {
            $elem.removeClass('disabled');
        }

        if ($elem.is('[type=text], textarea')) {
            $elem.val('');
        } else if ($elem.is('[type=radio]')) {
            $elem.prop('checked', false);
        } else {
            $elem
                .find('[type=text], textarea')
                .val('')
                .end()
                .find('[type=radio]')
                .prop('checked', false);
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

        _.each(VALIDATION, function (condition, questionSelector) {
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
        if (!condition) {
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

    this.checkItemValid = function ($parent, str) {
        var regexp = /(.*):(.*)/,
            arr = str.match(regexp),
            type = arr[1],
            selector = arr[2],
            $item = $parent.find(selector);

        switch (type) {
            case 'text':
            case 'textarea':
                if (!!$item.val()) {
                    return true;
                } else {
                    $item
                        .addClass('error-field')
                        .closest('.extension-question')
                        .addClass('error-field');
                    return false;
                }
                break;

            case 'radio':
                if ($item.filter(':checked').length > 0) {
                    return true;
                } else {
                    $parent.find(selector)
                        .next()
                        .addClass('error-field')
                        .closest('.extension-question')
                        .addClass('error-field');
                    return false;
                }
                break;

            case 'select':

        }
    };

    this.clearItemError = function ($question, str) {
        var regexp = /(.*):(.*)/,
            arr = str.match(regexp),
            type = arr[1],
            selector = arr[2],
            $item = $question.find(selector);

        switch (type) {
            case 'text':
            case 'textarea':
                $item
                    .removeClass('error-field')
                    .closest('.extension-question')
                    .removeClass('error-field');
                break;

            case 'radio':
                $item
                    .next()
                    .removeClass('error-field')
                    .closest('.extension-question')
                    .removeClass('error-field');
                break;
        }
    };

    this.checkDependOnTurnOn = function ($question, dependOn) {
        var regexp = /(.*):(.*)/,
            arr = dependOn.match(regexp),
            type = arr[1],
            selector = arr[2],
            $item = $question.find(selector);

        switch (type) {
            case 'radio':
                return $item.prop('checked');

            case 'group':
                return true;

            case 'text':
            case 'textarea':
                return !!$item.val();
        }
    };

    this.clearRequiredItemError = function ($question, requiredSelector) {
        Utility.checkArraySelfRun(requiredSelector, function (str) {
            var regexp = /(.*):(.*)/,
                arr = str.match(regexp),
                type = arr[1],
                selector = arr[2],
                $item = $question.find(selector);

            switch (type) {
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

    this.after('initialize', function () {
        this.initSelectMenu();

        this.on('input', {
            textItemSelector: this.onTextInput
        });

        Utility.hideProcessing();
    });
}

flight.component(
    WithChildren,
    Task,
    newPatientQuestionnaireTool
).attachTo('#main');
