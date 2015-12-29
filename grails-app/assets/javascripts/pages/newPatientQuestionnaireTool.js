require('../libs/MobileSelectMenu');

var flight = require('flight');
var MultipleDatePicker = require('../components/shared/components/MultipleDatePicker');
var PatientQuestionnaireTool = require('../components/task/patientQuestionnaire/PatientQuestionnaireTool');
var MobileSelectMenuDialog = require('../components/shared/components/MobileSelectMenuDialog');
var Utility = require('../utils/Utility');

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
            'radio:[name="choices.9-e-7-c"][value=1]': 'text:[name="choices.9-e-7-1s"]',
            'radio:[name="choices.9-c"][value=1]': [
                'text:[name="choices.9-e-1"]',
                'textarea:[name="choices.9-e-2"]',
                'textarea:[name="choices.9-e-3"]',
                'radio:[name="choices.9-e-4"]',
                'text:[name="choices.9-e-5"]',
                'radio:[name="choices.9-e-7-c"]'
            ]
        }
    },
    '#question10': {
        required: 'radio:[name="choices.10-c"]',
        depends: {
            'radio:[name="choices.10-e-1-c"][value=1]': 'text:[name="choices.10-e-1-1s"]',
            'radio:[name="choices.10-e-2-c"][value=1]': [
                'text:[name="choices.10-e-2-1s"]',
                'text:[name="choices.10-e-3"]'
            ],
            'radio:[name="choices.10-c"][value=1]': [
                'text:[name="choices.10-1s"]',
                'radio:[name="choices.10-e-1-c"]',
                'radio:[name="choices.10-e-2-c"]'
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
        selectMenuSelector: '.select-menu',
        multipleDatePickerSelector: '.multi-date-container',
        mobileEnterYearDialogSelector: '#mobile-enter-year-dialog',
        mobilePickTimeDialogSelector: '#mobile-pick-time-dialog',
        question12ChoiceSelector: '.question-12 .sub-question-answer'
    });

    this.children({
        multipleDatePickerSelector: {
            child: MultipleDatePicker,
            attributes: {
                maxDate: 0
            }
        }
    });

    this.dialogs([
        {
            selector: 'mobileEnterYearDialogSelector',
            event: 'showEnterYearMobileDialog',
            dialog: MobileSelectMenuDialog
        }, {
            selector: 'mobilePickTimeDialogSelector',
            event: 'showPickTimeMobileDialog',
            dialog: MobileSelectMenuDialog
        }
    ]);

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
        // init validation
        this.VALIDATION = VALIDATION;

        this.initSelectMenu();

        this.on(document, 'rc.multipleDatePickerSelect', this.onMultipleDatePickerChanged);
        this.on(document, 'rc.multipleDatePickerDelete', this.onMultipleDatePickerChanged);


        this.checkQuestion12ChoiceInMobile();
    });
}

flight.component(
    PatientQuestionnaireTool,
    newPatientQuestionnaireTool
).attachTo('#main');
