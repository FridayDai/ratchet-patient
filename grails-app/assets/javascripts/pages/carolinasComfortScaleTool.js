require('../components/common/initSetup');
require('../components/layout/Main');

var flight = require('flight');
var Task = require('../components/shared/functional/Task');
var ERROR_SECTION_LABEL = '<span class="error-label">Please complete the required field.</span>';

function ccsTool() {
    this.setErrorStatus = function ($question) {
        if ($question.hasClass('error')) {
            return;
        }

        $question.addClass('error');

        var $section =  $question.closest('.section-list');

        if(!$section.hasClass('error')) {
            $section.addClass('error').find('.section-title').append(ERROR_SECTION_LABEL);
        }

    };

    this.clearErrorStatus = function ($question) {
        $question = $($question);

        if ($question.hasClass('error')) {
            $question
                .removeClass('error')
                .find('.error-label')
                .remove();
            var section = $question.closest('.section-list');
            if(!section.find('.question-list.error').length) {
                section
                    .removeClass('error')
                    .find('.section-title')
                    .find('.error-label')
                    .remove();
            }

        }
    };


}

flight.component(Task, ccsTool).attachTo('#main');

