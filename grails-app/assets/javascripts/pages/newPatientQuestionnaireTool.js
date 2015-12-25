require('../components/common/initSetup');
require('../components/layout/Main');
require('velocity');
require('velocity-ui');
require('../libs/MobileSelectMenu');

var flight = require('flight');
var WithPage = require('../components/common/WithPage');
var Task = require('../components/shared/functional/Task');
var SaveComplexDraftAnswer = require('../components/shared/functional/SaveComplexDraftAnswer');
var ItemTriggerActions = require('../components/task/patientQuestionnaire/ItemTriggerActions');
var ValidationHandlers = require('../components/task/patientQuestionnaire/ValidationHandlers');
var DatePicker = require('../components/shared/components/DatePicker');
var MultipleDatePicker = require('../components/shared/components/MultipleDatePicker');
var MobileDatePickerDialog = require('../components/shared/components/MobileDatePickerDialog');
var MobileSelectMenuDialog = require('../components/shared/components/MobileSelectMenuDialog');
var Utility = require('../utils/Utility');

var QUESTION_REQUIRE_ERROR_LABEL = '<span class="error-label">This question is required.</span>';
var FIELD_REQUIRE_ERROR_LABEL = '<span class="error-label">Please complete required fields.</span>';

var QUESTION_12_VALIDATION = {};
for (var i = 0; i < 9; i++) {
    QUESTION_12_VALIDATION['group:{0}'.format(i)] = [
        'radio:[name="choices.12-{0}-c"]'.format(i),
        'select:[name="choices.12-{0}-s"]'.format(i)
    ];
}

var QUESTION_22_VALIDATION = {};
for (var i = 0; i < 4; i++) {
    QUESTION_22_VALIDATION['group:{0}'.format(i)] = [
        'radio:[name="choices.22-{0}"]'.format(i)
    ];
}

var VALIDATION = {
    '#question1': {
        required: 'radio:[name="choices.1-c"]',
        depends: {
            'radio:[name="choices.1-c"][value=1]': 'text:[name="choices.1-1s"]',
            'radio:[name="choices.1-c"][value=3]': 'text:[name="choices.1-3s"]',
            'radio:[name="choices.1-c"][value=5]': 'text:[name="choices.1-5s"]'
        }
    },
    '#question2': {
        required: 'radio:[name="choices.2"]'
    },
    '#question3': {
        required: 'radio:[name="choices.3-c"]',
        depends: {
            'radio:[name="choices.3-c"][value=6]': 'select:[name="choices.3-6s"]'
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
        required: 'radio:[name="choices.7-c"]',
        depends: {
            'radio:[name="choices.7-c"][value=1]': 'text:[name="choices.7-1s"]'
        }
    },
    '#question8': {
        required: 'radio:[name="choices.8"]'
    },
    '#question9': {
        required: 'radio:[name="choices.9-c"]',
        depends: {
            'radio:[name="choices.9-c"][value=1]': [
                'text:[name="choices.9-e-1"]',
                'textarea:[name="choices.9-e-2"]',
                'textarea:[name="choices.9-e-3"]',
                'radio:[name="choices.9-e-4"]',
                'text:[name="choices.9-e-5"]',
                'radio:[name="choices.9-e-7-c"]'
            ],
            'radio:[name="choices.9-e-7-c"][value=1]': 'text:[name="choices.9-e-7-1s"]'
        }
    },
    '#question10': {
        required: 'radio:[name="choices.10-c"]',
        depends: {
            'radio:[name="choices.10-c"][value=1]': [
                'text:[name="choices.10-1s"]',
                'radio:[name="choices.10-e-1-c"]',
                'radio:[name="choices.10-e-2-c"]'
            ],
            'radio:[name="choices.10-e-1-c"][value=1]': 'text:[name="choices.10-e-1-1s"]',
            'radio:[name="choices.10-e-2-c"][value=1]': [
                'text:[name="choices.10-e-2-1s"]',
                'text:[name="choices.10-e-3"]'
            ]
        }
    },
    '#question11': {
        required: 'radio:[name="choices.11-c"]',
        depends: {
            'radio:[name="choices.11-c"][value=1]': [
                'text:[name="choices.11-1s"]',
                'textarea:[name="choices.11-e-1"]'
            ]
        }
    },
    '#question12': {
        depends: QUESTION_12_VALIDATION
    },
    '#question13': {
        required: 'textarea:[name="choices.13"]'
    },
    '#question14': {
        required: 'textarea:[name="choices.14"]'
    },
    '#question15': {
        required: 'radio:[name="choices.15"]'
    },
    '#question16': {
        required: 'radio:[name="choices.16"]'
    },
    '#question17': {
        required: 'radio:[name="choices.17"]'
    },
    '#question18': {
        required: 'radio:[name="choices.18"]'
    },
    '#question19': {
        required: 'radio:[name="choices.19"]'
    },
    '#question20': {
        required: 'radio:[name="choices.20"]'
    },
    '#question21': {
        required: 'radio:[name="choices.21"]'
    },
    '#question22': {
        depends: QUESTION_22_VALIDATION
    }
};

function newPatientQuestionnaireTool() {
    this.attributes({
        startQuestionValidation: false,

        textItemSelector: '.specify-input, textarea',
        choiceItemSelector: '.answer, .sub-question-answer',
        selectMenuSelector: '.select-menu',
        datePickerSelector: '.date-picker',
        multipleDatePickerSelector: '.multi-date-container',
        mobileDatePickerDialogSelector: '#mobile-date-picker-dialog',
        mobileEnterYearDialogSelector: '#mobile-enter-year-dialog',
        mobilePickTimeDialogSelector: '#mobile-pick-time-dialog',
        question12ChoiceSelector: '.question-12 .sub-question-answer'
    });

    this.children({
        datePickerSelector: {
            child: DatePicker,
            attributes: {
                maxDate: 0
            }
        },
        multipleDatePickerSelector: {
            child: MultipleDatePicker,
            attributes: {
                maxDate: 0
            }
        }
    });

    this.dialogs([
        {
            selector: 'mobileDatePickerDialogSelector',
            event: 'rc.showMobileDatePickerDialog',
            dialog: MobileDatePickerDialog
        }, {
            selector: 'mobileEnterYearDialogSelector',
            event: 'showEnterYearMobileDialog',
            dialog: MobileSelectMenuDialog
        }, {
            selector: 'mobilePickTimeDialogSelector',
            event: 'showPickTimeMobileDialog',
            dialog: MobileSelectMenuDialog
        }
    ]);

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

            var $question = $target.closest('.question-list');

            this.validateQuestion($question);

            this.prepareDraftAnswer($target);
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
        this['trigger{0}Action'.format(_.capitalize(action))].call(this, $target, $currentItem);
    };

    this.initSelectMenu = function () {
        var self = this;

        this.select('selectMenuSelector').selectmenu({
            select: function (e) {
                var $target = $(e.target),
                    $question = $target.closest('.question-list');

                self.validateQuestion($question);

                var questionId = $target.attr('name').replace('choices.', '');
                self.draftAnswer[questionId] = $target.val();
                self.saveDraftAnswer();
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

        this.attr.startQuestionValidation = true;

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

    this.onMultipleDatePickerChanged = function (e, data) {
        var $parent = data.$elem.parent();
        var $hiddenField = $parent.find('[type=hidden]');
        var questionId = $hiddenField.attr('name').replace('choices.', '');

        $hiddenField.val(data.value);

        if (data.value) {
            this.draftAnswer[questionId] = data.value;
        } else {
            delete this.draftAnswer[questionId];
        }

        var $question = data.$elem.closest('.question-list');
        this.validateQuestion($question);

        this.saveDraftAnswer();
    };

    this.initDraftAnswer = function () {
        this.draftAnswer = this.select('formSelector').data('draft') || {};
    };

    this.prepareDraftAnswer = function ($target) {
        var $answer = $target.closest(this.attr.choiceItemSelector);
        var $hiddenRadio = $answer.find('.rc-choice-hidden');
        var questionId = $hiddenRadio.attr('name').replace('choices.', '');

        this.draftAnswer[questionId] = $hiddenRadio.val();

        this.saveDraftAnswer();
    };

    this.checkQuestion12ChoiceInMobile = function () {
        if (Utility.isMobile()) {
            var $checkedHiddens = this.select('question12ChoiceSelector').find('[type=radio]:checked');

            _.each($checkedHiddens, function (elem) {
                var $hiddenRadio = $(elem),
                    $answer = $hiddenRadio.closest('.sub-question-answer');

                this.checkTriggerTarget($answer);
            }, this);
        }
    };

    this.after('initialize', function () {
        this.initSelectMenu();
        this.initDraftAnswer();

        this.on(document, 'rc.datePickerSelect', this.onDatePickerSelected);
        this.on(document, 'rc.multipleDatePickerSelect', this.onMultipleDatePickerChanged);
        this.on(document, 'rc.multipleDatePickerDelete', this.onMultipleDatePickerChanged);

        this.on('input', {
            textItemSelector: this.onTextInput
        });

        this.on('.specify-input, textarea', 'blur', this.onTextBlur);

        this.checkQuestion12ChoiceInMobile();

        Utility.hideProcessing();
    });
}

flight.component(
    Task,
    WithPage,
    ItemTriggerActions,
    ValidationHandlers,
    SaveComplexDraftAnswer,
    newPatientQuestionnaireTool
).attachTo('#main');
