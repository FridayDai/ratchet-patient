require('../components/common/initSetup');
require('../components/layout/Main');

var flight = require('flight');
var Task = require('../components/shared/functional/Task');

var Utility = require('../utils/Utility');

var SECTION_ALLOW_MIN_FINISHED= [0,0,0,0,0 ,4,5,9,3,2 ,3,5,9,2,2];

function KOOSLike() {
    this.formSubmit = function () {
        var $sectionLists = this.select('formSelector').find('.section-list');
        var isValid = true;

        if (Utility.isIE()) {
            this.isFormSubmit = true;
        }

        _.each($sectionLists, function (sectionListEl) {
            var $sectionList = $(sectionListEl);
            var $notFinishedQuestions = this.getNotFinishedQuestions($sectionList);

            if ($notFinishedQuestions) {
                _.each($notFinishedQuestions, function (notFinishedQuestionEl) {
                    var $notFinishedQuestion = $(notFinishedQuestionEl);

                    this.errorQuestions.push($notFinishedQuestion);
                    this.setErrorStatus($notFinishedQuestion);

                    isValid = false;
                }, this);
            }
        }, this);

        if (!isValid) {
            this.scrollToTopError();
            this.errorQuestions = [];

            event.returnValue = false;
            return false;
        }

        this.disableSubmitButton();

        this.isFormSubmit = true;
    };

    this.getNotFinishedQuestions = function ($sectionList) {
        var sectionId = $sectionList.attr("value");
        var finishedQuestionList = $sectionList.find('.question-list').has('[type="radio"]:checked');

        if (finishedQuestionList.length < SECTION_ALLOW_MIN_FINISHED[sectionId]) {
            return $sectionList.find('.question-list').not(finishedQuestionList);
        }
    };

    this.onChoiceItemClicked = function (e) {
        var $target = $(e.target);

        if (!$target.is('input.rc-choice-hidden')) {
            $target.closest(this.attr.choiceItemSelector)
                .find('.rc-choice-hidden')
                .prop('checked', true);

            this.setTip();

            this.clearErrorStatus($target.closest('.question-list'));

            var $questionList = $target.closest('.question-list');
            var sectionId = $questionList.parent(".section-list").attr("value");
            var $siblings = $questionList.siblings(".question-list");
            var $checkedQuestions = $siblings.has('[type="radio"]:checked');

            // it's need to count self, so this plus 1
            if (1 + $checkedQuestions.length >= SECTION_ALLOW_MIN_FINISHED[sectionId]) {
                var optionals = $siblings.filter('.error');

                for (var i = 0, len = optionals.length; i < len; i++) {
                    this.clearErrorStatus(optionals[i]);
                }
            }

            this.saveDraftAnswer($target);
        }
    };
}

flight.component(Task, KOOSLike).attachTo('#main');
