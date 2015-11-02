require('../components/common/initSetup');
require('../components/layout/Main');

var flight = require('flight');
var Task = require('../components/shared/components/Task');

var Utility = require('../utils/Utility');

var SECTION_ALLOW_MIN_FINISHED= [0,0,0,0,0 ,4,5,9,3,2 ,3,5,9,2,2];

function KOOSLike() {
    this.formSubmit = function () {
        var $sectionLists = this.select('formSelector').find('.section-list');
        var isValid = true;

        if (Utility.isIE()) {
            this.isFormSubmit = true;
        }

        _.each($sectionLists, function ($sectionList) {
            var $notFinishedQuestions = this.getNotFinishedQuestions($sectionList);

            if ($notFinishedQuestions) {
                _.each($notFinishedQuestions, function ($notFinishedQuestion) {
                    this.errorQuestions.push($notFinishedQuestion);
                    this.setErrorStatus($notFinishedQuestion);

                    isValid = false;
                }, this);
            }
        }, this);

        if (!isValid) {
            this.scrollToTopError();

            event.returnValue = false;
            return false;
        }

        this.disableSubmitButton();

        this.isFormSubmit = true
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

        $target.closest('.rc-choice-hidden').prop('checked', true);

        this.setTip();

        if (this.errorQuestions.length > 0) {
            var $questionList = $target.closest('.question-list');
            var sectionId = $questionList.parent(".section-list").attr("value");
            var $siblings = $questionList.siblings(".question-list");
            var $checkedQuestions = siblings.has('[type="radio"]:checked');

            // it's need to count self, so this plus 1
            if(1 + $checkedQuestions.length >= SECTION_ALLOW_MIN_FINISHED[sectionId]) {
                for(var i= 0, len = $siblings.length; i < len; i++) {
                    this.clearErrorStatus($siblings[i]);
                }
            }
        }
    };
}

flight.component(Task, KOOSLike).attachTo('#main');
