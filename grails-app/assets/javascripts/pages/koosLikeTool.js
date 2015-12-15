require('../components/common/initSetup');
require('../components/layout/Main');

var flight = require('flight');
var Task = require('../components/shared/functional/Task');

var Utility = require('../utils/Utility');

var SECTION_ALLOW_MIN_FINISHED = [0, 0, 0, 0, 0, 4, 5, 9, 3, 2, 3, 5, 9, 2, 2];
var SECTION_SUCCESS_STRING = "Great! You’ve completed the minimum required questions for this section.";

var TIP_WRAP_TEMP = '<div class="tip-wrap"><div class="answer-limit-tip tip-container"></div></div>';

function KOOSLike() {
    this.attributes({
        fixedTipWrapSelector: '#header .answer-limit-tip'
    });

    this.scrollToTopError = function () {
        var first = this.errorQuestions[0];
        this.headerTipError(first);
        var top = first.offset().top;
        if (!Utility.isMobile()) {
            top -= 180;
        }

        window.scrollTo(0, top);
    };

    this.formSubmit = function (e) {
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

            e.returnValue = false;
            e.preventDefault();
            return false;
        }

        this.disableSubmitButton();

        this.isFormSubmit = true;
    };

    this.headerTipError = function ($questionList) {
        var $tip = $questionList.parent(".section-list").find('.answer-limit-tip:first');
        var tipText = $tip.text().trim();

        this.select('fixedTipSelector')
            .text(tipText)
            .attr('class', $tip.attr('class'))
            .addClass('tip-container');
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

    this.initHeaderTip = function () {
        this.sectionsOffset = {};

        _.forEach($(".section-list"), function (ele) {
            var $section = $(ele);
            var $tip = $section.find('.answer-limit-tip');
            var tipHeight = $tip.outerHeight();
            var sectionId = ele.id;
            var top = $section.offset().top;
            var bottom = top + $section.outerHeight(true);

            this.sectionsOffset[sectionId] = {
                self: $section,
                $tip: $tip,
                tipBottom: top + tipHeight,
                top: top,
                bottom: bottom
            };
        }, this);

        $(TIP_WRAP_TEMP)
            .appendTo(this.select('headerPanelSelector'))
            .hide();

        this.showTipInSection = (function () {
            var $header = $('#header');
            var $fixedTipWrap = $header.find('.tip-wrap');
            var $fixedTip = $fixedTipWrap.find('.answer-limit-tip');
            var $firstTip = $('form .answer-limit-tip:first');
            var firstTipBottom = $firstTip.offset().top + $firstTip.outerHeight();
            var $hiddenTip = null;

            return function () {
                var windowScrollTop = $(window).scrollTop(),

                // Since header will auto move up and down, so we should reduce moved up number
                    currentHeaderTopMoved = Number($header.css('top').replace('px', ''), 10),
                    headerHeight = $header.height() + currentHeaderTopMoved,
                    fixedTipHeight = $fixedTipWrap.outerHeight(),
                    fixedTipTop = 0,
                    fixedTipBottom = 0;

                if (Utility.isMobile()) {
                    if ($fixedTipWrap.is(':visible')) {
                        fixedTipTop = windowScrollTop;
                        fixedTipBottom = fixedTipTop + fixedTipHeight;
                    } else {
                        fixedTipTop = windowScrollTop;
                        fixedTipBottom = fixedTipTop;
                    }
                } else {
                    if ($fixedTipWrap.is(':visible')) {
                        fixedTipBottom = windowScrollTop + headerHeight;
                        fixedTipTop = fixedTipBottom - fixedTipHeight;
                    } else {
                        fixedTipTop = windowScrollTop + headerHeight;
                        fixedTipBottom = fixedTipTop;
                    }
                }

                if (fixedTipTop < firstTipBottom) {
                    $fixedTipWrap.hide();

                    if ($hiddenTip) {
                        $hiddenTip.removeClass('visibility-hide');
                    }

                    return;
                }

                _.forEach(this.sectionsOffset, function (section) {
                    if (fixedTipBottom >= section.top && fixedTipBottom < section.bottom) {
                        var tipText = section.$tip.text().trim();

                        if (tipText !== $fixedTip.text().trim()) {
                            $fixedTip
                                .text(tipText)
                                .attr('class', section.$tip.attr('class'))
                                .addClass('tip-container');
                        }

                        if ($hiddenTip) {
                            $hiddenTip.removeClass('visibility-hide');
                        }

                        $hiddenTip = section.$tip.addClass('visibility-hide');
                        $fixedTipWrap.show();
                    }
                });
            };
        })();
    };

    this.listenScroll = function() {
        var me = this,
            now = Date.now(),
            lastTime = now,
            $window = $(window);

        $(window).scroll(function () {
            now = Date.now();

            if ($window.scrollTop() <= 100) {
                me.delayShowFixTip();
            } else if(now - lastTime > 200) {
                me.delayShowFixTip();
                lastTime = now;
            }
        });

        this.delayShowFixTip();
    };

    this.delayShowFixTip = function () {
        setTimeout(_.bind(this.showTipInSection, this), 0);
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

        this.initHeaderTip();
        this.listenScroll();
    });
}

flight.component(Task, KOOSLike).attachTo('#main');
