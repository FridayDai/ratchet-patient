require('../components/common/initSetup');
require('../components/layout/Main');

var flight = require('flight');
var PatientQuestionnaireTool = require('../components/task/patientQuestionnaire/PatientQuestionnaireTool');

var QUESTION_4_VALIDATION = {};
for (var i = 0; i < 14; i++) {
    QUESTION_4_VALIDATION['group:{0}'.format(i)] = [
        'checkbox:[name="choices.4-{0}"]'.format(i)
    ];
}

var VALIDATION = {
    '#question1': {
        required: 'radio:[name="choices.1-c"]',
        depends: {
            //'radio:[name="choices.1-c"][value=2]': 'text:[name="choices.1-2s"]',
            //'radio:[name="choices.1-c"][value=4]': 'text:[name="choices.1-4s"]',
            'radio:[name="choices.1-c"][value=6]': 'text:[name="choices.1-6s"]'
        }
    },
    '#question2': {
        required: 'radio:[name="choices.2-c"]',
        depends: {
            'radio:[name="choices.2-c"][value=1]': 'radio:[name="choices.2-e-1"]'
        }
    },
    '#question3': {
        required: 'radio:[name="choices.3-c"]',
        depends: {
            'radio:[name="choices.3-e-1-c"][value=1]': 'text:[name="choices.3-e-1s"]',
            'radio:[name="choices.3-c"][value=2],[name="choices.3-c"][value=3]': 'radio:[name="choices.3-e-1-c"]'
        }
    },
    '#question4': {
        depends: QUESTION_4_VALIDATION
    }
};

function ReturnPatientQuestionnaireTool() {
    this.attributes({
    });

    this.after('initialize', function () {
        // init validation
        this.VALIDATION = VALIDATION;
    });
}

flight.component(
    PatientQuestionnaireTool,
    ReturnPatientQuestionnaireTool
).attachTo('#main');
