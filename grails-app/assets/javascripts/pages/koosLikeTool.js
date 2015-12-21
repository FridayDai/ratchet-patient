require('../components/common/initSetup');
require('../components/layout/Main');

var flight = require('flight');
var Task = require('../components/shared/functional/Task');

var Utility = require('../utils/Utility');
var STRINGs = require('../constants/Strings');

var SECTION_ALLOW_MIN_FINISHED = [0, 0, 0, 0, 0, 4, 5, 9, 3, 2, 3, 5, 9, 2, 2];

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

        var tipWrap = this.select('headerPanelSelector').find('.tip-wrap');
        if (tipWrap.length > 0) {
            top -= tipWrap.height();
        }

        window.scrollTo(0, top);
    };

    this.setErrorStatus = function ($question) {
        if ($question.hasClass('error')) {
            return;
        }

        $question.addClass('error');
    };

    this.formSubmit = function (e) {
        var $sectionLists = this.select('formSelector').find('.section-list');
        var isValid = true;
        // restore error section.
        this.sectionsOffset = {};

        if (Utility.isIE()) {
            this.isFormSubmit = true;
        }

        _.each($sectionLists, function (sectionListEl) {
            var $sectionList = $(sectionListEl);
            var limitNumber = SECTION_ALLOW_MIN_FINISHED[$sectionList.attr("value")];
            var remainNumber = 0;

            var questions = this.getQuestions($sectionList, limitNumber);

            if (!questions.enough) {
                var sectionId = sectionListEl.id;
                var top = $sectionList.offset().top;
                var bottom = top + $sectionList.outerHeight(true);
                remainNumber = limitNumber - questions.finishedNumber;

                this.sectionsOffset[sectionId] = {
                    self: $sectionList,
                    top: top,
                    bottom: bottom,
                    remainNumber: remainNumber
                };

                //set question error.
                _.each(questions.noFinishedQuestions, function (notFinishedQuestionEl) {
                    var $notFinishedQuestion = $(notFinishedQuestionEl);

                    this.errorQuestions.push($notFinishedQuestion);
                    this.setErrorStatus($notFinishedQuestion);

                    isValid = false;
                }, this);
            }
        }, this);

        if (!isValid) {
            this.initHeaderTip();
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

    this.getQuestions = function ($sectionList, limitNumber) {

        var finishedQuestionList = $sectionList.find('.question-list').has('[type="radio"]:checked');
        var finishedNumber = finishedQuestionList.length;

        return {
            finishedNumber: finishedNumber,
            noFinishedQuestions: $sectionList.find('.question-list').not(finishedQuestionList),
            enough: finishedNumber >= limitNumber
        };
    };

    this.checkLimitAnswer = function ($section) {
        var $limitTip = $('#header').find('.answer-limit-tip');
        var sectionId = $section[0].id;
        var sectionOffset = this.sectionsOffset[sectionId];
        var remainNumber = sectionOffset.remainNumber;

        if (remainNumber > 1) {
            this.sectionsOffset[sectionId].remainNumber = --remainNumber;

            $limitTip
                .addClass('error')
                .text(STRINGs.SECTION_ERROR_STRING.format(remainNumber));
        } else {
            //remove this section's questions error status
            $section.find('.question-list.error').removeClass('error');
            //change the header fix tip to success
            $limitTip
                .removeClass('error')
                .addClass('success')
                .text(STRINGs.SECTION_SUCCESS_STRING);

            setTimeout(function () {
                $limitTip.fadeOut("slow", function () {
                    $(this).removeClass('success');
                });
            }, 1000);

            delete this.sectionsOffset[sectionId];
            //tear down the memory.
            if (this.sectionsOffset.length === 0) {
                this.showErrorTip = null;
            }
        }
    };

    this.onChoiceItemClicked = function (e) {
        var $target = $(e.target);

        if (!$target.is('input.rc-choice-hidden')) {
            $target.closest(this.attr.choiceItemSelector)
                .find('.rc-choice-hidden')
                .prop('checked', true);

            this.clearErrorStatus($target.closest('.question-list'));

            this.checkLimitAnswer($target.closest('.section-list'));

            this.prepareDraftAnswer($target);
        }
    };

    this.showTipInSection = function () {
        var $header = $('#header');
        var $fixedTipWrap = $header.find('.tip-wrap');
        var $fixedTip = $fixedTipWrap.find('.answer-limit-tip');
        var self = this;

        return function () {
            var windowScrollTop = $(window).scrollTop(),
            // Since header will auto move up and down, so we should reduce moved up number
                currentHeaderTopMoved = Number($header.css('top').replace('px', ''), 10),
                headerHeight = $header.height() + currentHeaderTopMoved,
                fixedTipHeight = $fixedTipWrap.outerHeight(),
                fixedTipTop = 0,
                fixedTipBottom = 0;

            if (Utility.isMobile()) {
                if ($fixedTip.is(':visible')) {
                    fixedTipTop = windowScrollTop;
                    fixedTipBottom = fixedTipTop + fixedTipHeight;
                } else {
                    fixedTipTop = windowScrollTop;
                    fixedTipBottom = fixedTipTop;
                }
            } else {
                if ($fixedTip.is(':visible')) {
                    fixedTipBottom = windowScrollTop + headerHeight;
                    fixedTipTop = fixedTipBottom - fixedTipHeight;
                } else {
                    fixedTipTop = windowScrollTop + headerHeight;
                    fixedTipBottom = fixedTipTop;
                }
            }

            //section error
            $fixedTip.hide();
            _.forEach(self.sectionsOffset, function (section) {
                if (fixedTipBottom >= section.top && fixedTipBottom < section.bottom) {
                    var tipText = STRINGs.SECTION_ERROR_STRING.format(section.remainNumber);
                    $fixedTip
                        .text(tipText)
                        .addClass('error')
                        .show();
                }
            });
        };
    };

    this.initHeaderTip = _.once(function () {
        $(TIP_WRAP_TEMP)
            .appendTo(this.select('headerPanelSelector'))
            .find('.answer-limit-tip')
            .hide();

        this.showErrorTip = this.showTipInSection();
        this.listenScroll();
    }, this);

    this.listenScroll = function () {
        var me = this,
            now = Date.now(),
            lastTime = now,
            $window = $(window);

        $(window).scroll(function () {
            now = Date.now();

            if ($window.scrollTop() <= 100) {
                me.delayShowFixTip();
            } else if (now - lastTime > 200) {
                me.delayShowFixTip();
                lastTime = now;
            }
        });

        this.delayShowFixTip();
    };

    this.delayShowFixTip = function () {
        setTimeout(_.bind(this.showErrorTip, this), 0);
    };
}

flight.component(Task, KOOSLike).attachTo('#main');
