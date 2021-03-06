require('headroom');
require('jquery-headroom');
require('velocity');

var Utility = require('../../../utils/Utility');
var URLs = require('../../../constants/Urls');

var LEAVE_CONFIRMATION_MSG = "We won't be able to save your progress as the result is time sensitive." +
    "Leaving the task half way will lose your progress.";

var ERROR_LABEL = '<span class="error-label">This question is required.</span>';

var TIPS = [
    'Losing weight enhances your chance of recovery.',
    'Smoking inhabited fusion of the bone.',
    'Physical therapy could help with recovery.',
    'Avoid bending, lifting heavy objects and twisting.',
    'Yoga, Pilates and Tai Chi might help alleviate pain.'
];

function Task() {
    this.attributes({
        maintenanceTipSelector: '#maintenance',
        headerPanelSelector: '#header',
        formSelector: 'form',
        submitButtonSelector: 'input[type="submit"]',
        choiceItemSelector: '.answer',
        questionLabelSelector: '.question',
        questionErrorMarkerSelector: '.error-label',
        taskIdFieldSelector: '[name="taskId"]',
        treatmentCodeFieldSelector: '[name="treatmentCode"]',
        taskCodeFieldSelector: '[name="code"]',
        radioHiddenFieldSelector: '.rc-choice-hidden',
        logoLinkSelector: '#logo-link'
    });

    this.initPrivates = function () {
        var $taskId = this.select('taskIdFieldSelector');
        var $treatmentCode = this.select('treatmentCodeFieldSelector');
        var $taskCode = this.select('taskCodeFieldSelector');

        this.isFormSubmit = false;
        this.taskId = $taskId.val().trim();
        this.code = $treatmentCode.val().trim();

        if (!this.code) {
            this.code = $taskCode.val().trim();
        }

        this.errorQuestions = [];
    };

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
            }
        };
    })();

    this.initHeadroom = function () {
        var me = this;
        var $header = this.select('headerPanelSelector');


        $header.headroom({
            tolerance: {
                down: 10,
                up: 20
            },
            offset: 205,
            onTop: function () {
                me.toggleHeader(true);
            },
            onNotTop: function () {
                me.toggleHeader();
            }
        });
    };

    this.initCloseConfirmation = function () {
        var me = this;

        $(window).on('beforeunload', function (event) {
            if (!me.isFormSubmit && me.select('submitButtonSelector').length > 0) {
                var confirmationMessage = LEAVE_CONFIRMATION_MSG;

                (event || window.event).returnValue = confirmationMessage;
                return confirmationMessage;
            } else {
                me.isFormSubmit = false;
            }
        });
    };

    this.isValid = function () {
        var $questionLists = this.select('formSelector').find('.question-list');
        var isValid = true;

        _.each($questionLists, function (questionEl) {
            var $question = $(questionEl);

            if (!this.isQuestionChecked($question)) {
                this.errorQuestions.push($question);
                this.setErrorStatus($question);

                isValid = false;
            }
        }, this);

        return isValid;
    };

    this.formSubmit = function (e) {
        if (Utility.isIE()) {
            this.isFormSubmit = true;
        }

        if (!this.isValid()) {
            this.scrollToTopError();
            this.errorQuestions.length = 0;

            e.returnValue = false;
            e.preventDefault();
            return false;
        }

        this.disableSubmitButton();

        this.isFormSubmit = true;
    };

    this.isQuestionChecked = function ($question) {
        if ($question.data('optional') === true) {
            return true;
        }

        var radios = $question.find('[type="radio"]');

        for (var i = 0, len = radios.length; i < len; i++) {
            if (radios[i].checked) {
                return true;
            }
        }

        return false;
    };

    this.setErrorStatus = function ($question) {
        if ($question.hasClass('error')) {
            return;
        }

        $question
            .addClass('error')
            .find('.question')
            .append(ERROR_LABEL);
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

    this.scrollToTopError = function () {
        var first = this.errorQuestions[0],
            $header = this.select('headerPanelSelector'),
            headerMovedTop = parseInt($header.css('top').replace('px', ''), 10),
            headerHeight = $header.height(),
            visibleHeaderTop = headerHeight + headerMovedTop,
            top = first.offset().top;

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

    this.disableSubmitButton = function () {
        this.select('submitButtonSelector').prop('disabled', true);
    };

    this.onChoiceItemClicked = function (e) {
        var $target = $(e.target);

        if (!$target.is('input.rc-choice-hidden')) {
            $target
                .closest(this.attr.choiceItemSelector)
                .find('[type="radio"].rc-choice-hidden')
                .prop('checked', true);

            this.setTip();

            this.clearErrorStatus($target.closest('.question-list'));

            this.prepareDraftAnswer($target);
        }
    };

    this.prepareDraftAnswer = function ($target) {
        var $answer = $target.closest('.answer');
        var $hiddenRadio = $answer.find('.rc-choice-hidden');
        var questionId = $hiddenRadio.attr('name').replace('choices.', '');
        var answerId = $hiddenRadio.val().replace(/\..*/gi, '');

        this.saveDraftAnswer(questionId, answerId);
    };

    this.saveDraftAnswer = function (questionId, answerId) {
        $.ajax({
            url: URLs.SAVE_DRAFT_ANSWER.format(this.taskId),
            type: 'POST',
            data: {
                code: this.code,
                questionId: questionId,
                answerId: answerId,
                sendTime: Date.now()
            }
        });
    };

    this.setTip = (function () {
        var $tipContent = $('.sub-header').find('.tip-content');
        var curTipIndex = 1;

        return function () {
            if (curTipIndex === TIPS.length) {
                curTipIndex = 0;
            }

            $tipContent.text(TIPS[curTipIndex]);

            curTipIndex++;
        };
    })();

    this.initLogoLink = function () {
        $(this.attr.logoLinkSelector).attr('href', window.location.href);
    };

    this.after('initialize', function () {
        this.initHeadroom();
        this.initLogoLink();

        this.initPrivates();
        this.initCloseConfirmation();

        this.on('submit', {
            formSelector: this.formSubmit
        });

        this.on('click', {
            choiceItemSelector: this.onChoiceItemClicked
        });
    });
}

module.exports = Task;
