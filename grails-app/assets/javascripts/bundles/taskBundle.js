//= require ../bower_components/headroom.js/dist/headroom
//= require ../bower_components/headroom.js/dist/jQuery.headroom
//= require ../share/announcement

function taskBundle() {
    'use strict';

    var isForm = false;

    var TIPS = [
        'Losing weight enhances your chance of recovery.',
        'Smoking inhabited fusion of the bone.',
        'Physical therapy could help with recovery.',
        'Avoid bending, lifting heavy objects and twisting.',
        'Yoga, Pilates and Tai Chi might help alleviate pain.'
    ];

    var errorQuestions = [];

    var choicesLimit= [0,0,0,0,0 ,4,5,9,3,2 ,3,5,9,2,2];

    var setTip = (function () {
        var subHeaderEl = document.getElementsByClassName('sub-header')[0];
        var tipContent = subHeaderEl.querySelector('.tip-content');
        var curTipIndex = 1;

        return function () {
            if (curTipIndex === TIPS.length) {
                curTipIndex = 0;
            }

            tipContent.innerText = TIPS[curTipIndex];

            curTipIndex++;
        };
    })();

    function isIE() {

        var ua = window.navigator.userAgent;
        var msie = ua.indexOf("MSIE ");

        return (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) ? true : false;
    }

    function makeRowSelect() {
        var answerEls = document.getElementsByClassName('answer');

        for (var i = 0, len = answerEls.length; i < len; i++) {
            attachAnswerEvent(answerEls[i]);
        }
    }

    function attachAnswerEvent(el) {
        function findParentQuestionList(el) {
            var regex = /(^question\-list|\squestion\-list)(\s|$)/;
            var cur = el.parentNode;

            while (!regex.test(cur.className)) {
                cur = cur.parentNode;
            }

            return cur;
        }

        $(el).click(function () {
            var type = $('input[name=taskType]').val();

            this.querySelector('.rc-choice-hidden').checked = true;
            setTip();

            if(errorQuestions.length > 0) {
                clearErrorStatus(findParentQuestionList(this));

                if(type === "7" || type === "8") {
                    var questionList = findParentQuestionList(this);
                    var sectionId = $(questionList).parent(".section-list").attr("value");
                    var siblings = $(questionList).siblings(".question-list");
                    var checkedQuestions = siblings.has('[type="radio"]:checked');

                    // it's need to count self, so this plus 1
                    if(1 + checkedQuestions.length >= choicesLimit[sectionId]) {
                        for(var i= 0, len = siblings.length; i < len; i++) {
                            clearErrorStatus(siblings[i]);
                        }
                    }

                }
            }
        });
    }

    function hasChecked(questionListEl) {
        if ($(questionListEl).data('optional') === true) {
            return true;
        }

        var radios = questionListEl.querySelectorAll('[type="radio"]');

        for (var i = 0, len = radios.length; i < len; i++) {
            if (radios[i].checked) {
                return true;
            }
        }

        return false;
    }

    function questionsNotDone(sectionListEl) {

        var sectionId = sectionListEl.attr("value");
        var questionList = sectionListEl.find('.question-list').has('[type="radio"]:checked');
        var notDoneQuestion = sectionListEl.find('.question-list').not(questionList);

       if(questionList.length < choicesLimit[sectionId]) {
            return notDoneQuestion;
       }
        return false;
    }

    function setErrorStatus(questionListEl) {
        var regex = /\serror($|\s)/;

        if (regex.test(questionListEl.className)) {
            return false;
        }

        questionListEl.className += ' error';

        var errorLabel = '<span class="error-label">This question is required.</span>';

        questionListEl.querySelector('.question').innerHTML += errorLabel;
    }

    function clearErrorStatus(questionListEl) {
        var regexp = /(^error|\serror)(\s|$)/;

        if (regexp.test(questionListEl.className)) {
            questionListEl.className = questionListEl.className.replace(' error', '');

            var question = questionListEl.querySelector('.question');
            var errorLabel = question.querySelector('.error-label');

            if (errorLabel) {
                question.removeChild(errorLabel);
            }
        }
    }

    function isMobile() {
        return window.innerWidth < 768;
    }

    function scrollToError() {
        var first = errorQuestions[0];
        var top = first.offsetTop;

        if (!isMobile()) {
            top -= 180;
        }

        window.scrollTo(0, top);
    }

    function setValidation() {
        var formEl = document.getElementsByTagName('form')[0];
        var questionLists = formEl.querySelectorAll('.question-list');
        var sectionLists = formEl.querySelectorAll('.section-list');
        var type = $('input[name=taskType]').val();


        $(formEl).submit(function (event) {
            var isValid = true;
            errorQuestions = [];

            if (isIE()) {
                isForm = true;
            }

            if(type === "7" || type === "8"){
                isValid = sectionQuestionValid(sectionLists);
            } else{
                for (var i = 0, len = questionLists.length; i < len; i++) {
                    if (!hasChecked(questionLists[i])) {
                        errorQuestions.push(questionLists[i]);
                        setErrorStatus(questionLists[i]);

                        isValid = false;
                    }
                }
            }

            if (!isValid) {
                scrollToError();

                event.returnValue = false;
                return false;
            }

            $('input[type="submit"]').prop('disabled', true);

            isForm = true;
        });
    }

    function sectionQuestionValid(sectionLists) {

        var isValid = true;
        for(var j= 0, sectionLen= sectionLists.length; j < sectionLen; j++) {
            var questionsUndone = questionsNotDone($(sectionLists[j]));

            if(questionsUndone) {
                for(var k = 0, questionLen = questionsUndone.length; k < questionLen; k++) {
                    errorQuestions.push(questionsUndone[k]);
                    setErrorStatus(questionsUndone[k]);
                    isValid = false;
                }
            }
        }
        return isValid;
    }

    function setCloseConfirmation() {
        $(window).on('beforeunload', function (event) {
            if (!isForm) {
                var confirmationMessage = "We won't be able to save your progress as the result is time sensitive." +
                    "Leaving the task half way will lose your progress.";

                (event || window.event).returnValue = confirmationMessage;
                return confirmationMessage;
            } else {
                isForm = false;
            }
        });
    }

    function init() {
        $("#header").headroom({
            tolerance: {
                down: 10,
                up: 20
            },
            offset: 205,
            onUnpin: function () {
                var headerEl = $('#header');

                if ($('#maintenance').length) {
                    this.classes.unpinned = "headroom--banner--unpinned";

                    if (headerEl.hasClass('headroom--unpinned')) {
                        headerEl.removeClass('headroom--unpinned');
                    }
                } else {
                    this.classes.unpinned = "headroom--unpinned";

                    if (headerEl.hasClass('headroom--banner--unpinned')) {
                        headerEl.removeClass('headroom--banner--unpinned');
                    }
                }
            }
        });

        setCloseConfirmation();

        setValidation();

        makeRowSelect();
    }

    init();
}

if (window.addEventListener) {
    window.addEventListener("load", taskBundle, false);
} else if (window.attachEvent) {
    window.attachEvent("onload", taskBundle);
}
