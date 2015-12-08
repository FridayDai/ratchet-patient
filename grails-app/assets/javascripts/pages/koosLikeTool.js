require('../components/common/initSetup');
require('../components/layout/Main');

var flight = require('flight');
var Task = require('../components/shared/functional/Task');

var Utility = require('../utils/Utility');

var SECTION_ALLOW_MIN_FINISHED = [0, 0, 0, 0, 0, 4, 5, 9, 3, 2, 3, 5, 9, 2, 2];
var SECTION_SUCCESS_STRING = "Great! You’ve completed the minimum required questions for this section.";

function KOOSLike() {
    this.scrollToTopError = function () {
        var first = this.errorQuestions[0];
        this.headerTipError(first);
        var top = first.offset().top;
        if (!Utility.isMobile()) {
            top -= 180;
        }

        window.scrollTo(0, top);
    };

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

    this.headerTipError = function ($questionList) {
        $('#header .tip-wrap').remove();
        var tip = $questionList.parent(".section-list").find('.answer-limit-tip:first');
        tip.clone().addClass('tip-container').appendTo('#header').wrap("<div class='tip-wrap'></div>");
    };

    this.getNotFinishedQuestions = function ($sectionList, noErrorTip) {
        var sectionId = $sectionList.attr("value");
        var finishedQuestionList = $sectionList.find('.question-list').has('[type="radio"]:checked');
        if (finishedQuestionList.length < SECTION_ALLOW_MIN_FINISHED[sectionId]) {
            if (!noErrorTip) {
                $sectionList.find('.answer-limit-tip').addClass('error');
            }
            return $sectionList.find('.question-list').not(finishedQuestionList);
        } else {
            $sectionList.find('.answer-limit-tip').addClass('success').text(SECTION_SUCCESS_STRING);
        }
    };

    this.checkLimitAnswer = function ($questionList) {
        var sectionId = $questionList.parent(".section-list").attr("value");
        var $siblings = $questionList.siblings(".question-list");
        var $sectionList = $questionList.closest('.section-list');
        var $checkedQuestions = $siblings.has('[type="radio"]:checked');

        // it's need to count self, so this plus 1
        if (1 + $checkedQuestions.length >= SECTION_ALLOW_MIN_FINISHED[sectionId]) {
            var optionals = $siblings.filter('.error');
            for (var i = 0, len = optionals.length; i < len; i++) {
                this.clearErrorStatus(optionals[i]);
            }

            //change the section tip to success
            $sectionList.find('.answer-limit-tip').addClass('success').text(SECTION_SUCCESS_STRING);
            //change the header fix tip to success
            $('#header').find('.answer-limit-tip').addClass('success').text(SECTION_SUCCESS_STRING);
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
            this.checkLimitAnswer($questionList);

            this.prepareDraftAnswer($target);
        }
    };

    this.showTipInSection = function () {
        var top = $('html,body').scrollTop();
        var firstLimitTop = $('form .answer-limit-tip:first').offset().top;
        var tipHeight = 33;
        var bottom = $('#header')[0].getBoundingClientRect().bottom || $('#header').height();
        var headerBaseline = top + bottom;
        var headerTip = $('#header .tip-wrap');
        var self = this;

        if (top < (firstLimitTop - bottom + tipHeight)) {
            headerTip.remove();
            return;
        }

        _.forEach(this.sectionsOffset, function (section, sectionId) {
            if (self.sectionToken[sectionId] && headerBaseline > section.top && headerBaseline < section.bottom) {
                setTimeout(function () {
                    var answerTip = $("#{0}".format(sectionId)).find('.answer-limit-tip');

                    headerTip.remove();
                    answerTip.clone().addClass('tip-container')
                        .appendTo('#header').wrap("<div class='tip-wrap'></div>");

                    self.sectionToken[sectionId] = true;
                    //this section toke is idle.
                }, 10);

                self.sectionToken[sectionId] = false;
                //this section token is in using.
            }
        });
    };

    this.listenScroll = function() {
        $(window).scroll(_.bind(this.showTipInSection, this));
    };

    this.initHeaderTip = function () {
        var token = {};
        var sectionListOffset = {};
        _.forEach($(".section-list"), function (ele) {
            var sectionId = ele.id;
            var top = $(ele).offset().top;
            var bottom = top + $(ele).outerHeight();
            sectionListOffset[sectionId] = {
                top: top,
                bottom: bottom
            };
            token[sectionId] = true;
        });
        this.sectionsOffset = sectionListOffset;
        this.sectionToken = token;
    };

    this.initDraftAnswer = function () {
        var $sectionLists = this.select('formSelector').find('.section-list');
        _.each($sectionLists, function (sectionListEl) {
            var $sectionList = $(sectionListEl);
            this.getNotFinishedQuestions($sectionList, true);
        }, this);
    };

    this.after('initialize', function () {
        this.initDraftAnswer();

        if (!Utility.isMobile()) {
            this.initHeaderTip();
            this.listenScroll();
        }
    });
}

flight.component(Task, KOOSLike).attachTo('#main');
