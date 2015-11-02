require('jquery-headroom');
var flight = require('flight');
var Utility = require('../../../utils/Utility');

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
        choiceItemSelector: '.answer'
    });

    this.initHeadroom = function () {
        var $header = this.select('headerPanelSelector');
        var $maintenanceTip = this.select('maintenanceTipSelector');

        $header.headroom({
            tolerance: {
                down: 10,
                up: 20
            },
            offset: 205,
            onUnpin: function () {
                if ($maintenanceTip.length) {
                    this.classes.unpinned = "headroom--banner--unpinned";

                    if ($header.hasClass('headroom--unpinned')) {
                        $header.removeClass('headroom--unpinned');
                    }
                } else {
                    this.classes.unpinned = "headroom--unpinned";

                    if ($header.hasClass('headroom--banner--unpinned')) {
                        $header.removeClass('headroom--banner--unpinned');
                    }
                }
            }
        });
    };

    this.isFormSubmit = false;

    this.initCloseConfirmation = function () {
        var me = this;

        $(window).on('beforeunload', function (event) {
            if (!me.isFormSubmit) {
                var confirmationMessage = LEAVE_CONFIRMATION_MSG;

                (event || window.event).returnValue = confirmationMessage;
                return confirmationMessage;
            } else {
                me.isFormSubmit = false;
            }
        });
    };

    this.errorQuestions = [];

    this.formSubmit = function () {
        var $questionLists = this.select('formSelector').find('.question-list');
        var isValid = true;

        if (Utility.isIE()) {
            this.isFormSubmit = true;
        }

        _.each($questionLists, function ($question) {
            if (!this.isQuestionChecked($question)) {
                this.errorQuestions.push($question);
                this.setErrorStatus($question);

                isValid = false;
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
        if ($question.hasClass('error')) {
            $question
                .removeClass('error')
                .find('.error-label')
                .remove();
        }
    };

    this.scrollToTopError = function () {
        var first = this.errorQuestions[0];
        var top = first.offsetTop;

        if (!Utility.isMobile()) {
            top -= 180;
        }

        window.scrollTo(0, top);
    };

    this.disableSubmitButton = function () {
        this.select('submitButtonSelector').prop('disabled', true);
    };

    this.onChoiceItemClicked = function (e) {
        var $target = $(e.target);

        $target.closest('.rc-choice-hidden').prop('checked', true);

        this.setTip();

        if (this.errorQuestions.length > 0) {
            this.clearErrorStatus($target.closest('.question-list'));
        }
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

    this.after('initialize', function () {
        this.initHeadroom();
        this.initCloseConfirmation();

        this.on('submit', {
            formSelector: this.formSubmit
        });

        this.on('click', {
            choiceItemSelector: this.onChoiceItemClicked
        })
    });
}

module.exports = flight.component(Task);
