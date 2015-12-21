require('../components/common/initSetup');
require('../components/layout/Main');

var flight = require('flight');
var Task = require('../components/shared/functional/Task');

var STRINGs = require('../constants/Strings');
var Utility = require('../utils/Utility');
var TIP_WRAP_TEMP = '<div class="tip-wrap"><div class="answer-limit-tip tip-container"></div></div>';
var limitNumber = 5;

function ODILike() {
    this.attributes({
        questionnaireInfoSelector: '.task-content .info'
    });

    this.toggleHeader = (function () {
        var top = 0;
        var $header = $('#header');
        var $maintenance = $('#maintenance');
        var $mainHeader = $('.main-header');

        return function (reset) {
            if (!Utility.isMobile()) {
                if (reset) {
                    top = 0;
                } else {
                    top = $mainHeader.outerHeight();

                    if ($maintenance.is(':visible')) {
                        top += $maintenance.outerHeight();
                    }
                }

                setTimeout(function () {
                    $header.velocity({top: -top}, {duration: 200});
                }, 0);
            } else {
                if (reset) {
                    $header.find('.tip-wrap')
                        .css('position', 'relative')
                        .find('.answer-limit-tip')
                        .css('position', 'absolute');
                } else {
                    $header.find('.tip-wrap')
                        .css('position', 'fixed')
                        .find('.answer-limit-tip')
                        .css('position', 'static');
                }
            }
        };
    })();

    this.fixErrorTip = _.once(function (answerNumber) {
        var
            $limitTip,
            remainNumber = limitNumber - answerNumber;

        $(TIP_WRAP_TEMP)
            .appendTo(this.select('headerPanelSelector'))
            .find('.answer-limit-tip')
            .addClass('error')
            .text(STRINGs.SECTION_ERROR_STRING.format(remainNumber));

        // In mobile, add info height to put tip, while scroll to top
        if (Utility.isMobile()) {
            this.select('questionnaireInfoSelector').css('padding', '57px 20px 30px');
        }

        $limitTip = this.select('headerPanelSelector').find('.answer-limit-tip');

        return function () {
            if (remainNumber > 1) {
                remainNumber--;
                $limitTip
                    .addClass('error')
                    .text(STRINGs.SECTION_ERROR_STRING.format(remainNumber));
            } else {
                //remove all question error status
                this.select('formSelector').find('.question-list.error').removeClass('error');
                //change the header fix tip to success
                $limitTip
                    .removeClass('error')
                    .addClass('success')
                    .text(STRINGs.SECTION_SUCCESS_STRING);

                setTimeout(function () {
                    $limitTip.fadeOut("slow");
                }, 1000);

                //tear down this memory
                this.checkLimitAnswer = null;
            }
        };

    });

    this.setErrorStatus = function ($question) {
        if ($question.hasClass('error')) {
            return;
        }

        $question.addClass('error');
    };

    this.getNotFinishedQuestions = function () {
        var finishedQuestionList = this.select('formSelector').find('.question-list').has('[type="radio"]:checked');

        if (finishedQuestionList.length < limitNumber) {
            return this.select('formSelector').find('.question-list').not(finishedQuestionList);
        } else {
            return false;
        }
    };

    this.formSubmit = function (e) {
        var isValid = true;

        if (Utility.isIE()) {
            this.isFormSubmit = true;
        }

        var $notFinishedQuestions = this.getNotFinishedQuestions();
        if ($notFinishedQuestions) {
            _.each($notFinishedQuestions, function (questionEl) {
                var $question = $(questionEl);

                this.errorQuestions.push($question);
                this.setErrorStatus($question);

                isValid = false;
            }, this);
        }

        if (!isValid) {
            this.checkLimitAnswer = this.fixErrorTip(10 - this.errorQuestions.length);
            this.scrollToTopError();
            this.errorQuestions.length = 0;

            e.returnValue = false;
            e.preventDefault();
            return false;
        }

        this.disableSubmitButton();

        this.isFormSubmit = true;
    };

    this.onChoiceItemClicked = function (e) {
        var $target = $(e.target);

        if (!$target.is('input.rc-choice-hidden')) {
            $target
                .closest(this.attr.choiceItemSelector)
                .find('[type="radio"].rc-choice-hidden')
                .prop('checked', true);

            this.clearErrorStatus($target.closest('.question-list'));

            //only after submit, we will check limit answer.
            if (_.isFunction(this.checkLimitAnswer)) {
                this.checkLimitAnswer();
            }

            this.prepareDraftAnswer($target);
        }
    };

}

flight.component(Task, ODILike).attachTo('#main');
