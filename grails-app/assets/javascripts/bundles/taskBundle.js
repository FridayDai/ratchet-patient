(function (undefined) {
    'use strict';

    var isForm = false;

    var TIPS = [
        'Losing weight enhances your chance of recovery.',
        'Have you learned the “log-rolling” technique?',
        'Back pain improves up to 2 years after surgery.',
        'Smoking inhabited fusion of the bone.',
        'Physical therapy could help with recovery.',
        'Avoid bending, lifting heavy objects and twisting.',
        'Yoga, Pilates and Tai Chi might help alleviate pain.'
    ];

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

        el.addEventListener('click', function () {

            this.querySelector('.rc-choice-hidden').checked = true;
            setTip();
            clearErrorStatus(findParentQuestionList(this));
        });
    }

    function hasChecked(questionListEl) {
        if (questionListEl.dataset.optional === 'true') {
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

    var errorQuestions = [];

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

        formEl.addEventListener('submit', function (event) {
            var isValid = true;
            errorQuestions = [];

            for (var i = 0, len = questionLists.length; i < len; i++) {
                if (!hasChecked(questionLists[i])) {
                    errorQuestions.push(questionLists[i]);
                    setErrorStatus(questionLists[i]);

                    isValid = false;
                }
            }

            if (!isValid) {
                scrollToError();

                event.returnValue = false;
                return false;
            }

            isForm = true;
        });
    }

    function setCloseConfirmation() {
        window.addEventListener('beforeunload', function (event) {
            var confirmationMessage = "We won't be able to save your progress as the result is time sensitive." +
                "Leaving the task half way will lose your progress.";

            if (!isForm) {
                (event || window.event).returnValue = confirmationMessage;
                return confirmationMessage;
            }
        });
    }

    function init() {
        setValidation();

        setCloseConfirmation();

        makeRowSelect();
    }

    init();
})
();
