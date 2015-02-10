(function (undefined) {
    'use strict';

    function makeRowSelect() {
        var answerEls = document.getElementsByClassName('answer');

        function findParentQuestionList(el) {
            var regex = /(^question\-list|\squestion\-list)(\s|$)/;
            var cur = el.parentNode;

            while(!regex.test(cur.className)) {
                cur = cur.parentNode;
            }

            return cur;
        }

        for (var i = 0, len = answerEls.length; i < len; i++) {
            answerEls[i].addEventListener('click', function () {

                this.querySelector('.rc-choice-hidden').checked = true;

                clearErrorStatus(findParentQuestionList(this));
            });
        }
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
        questionListEl.className += ' error';

        var errorLabel = '<span class="error-label">This question is required.</span>';

        questionListEl.querySelector('.question').innerHTML += errorLabel;
    }

    function clearErrorStatus(questionListEl) {
        var regexp = /(^error|\serror)(\s|$)/

        if (regexp.test(questionListEl.className)) {
            questionListEl.className = questionListEl.className.replace(' error', '');

            var question = questionListEl.querySelector('.question');
            var errorLabel = question.querySelector('.error-label');

            if (errorLabel) {
                question.removeChild(errorLabel);
            }
        }
    }

    function setValidation() {
        var formEl = document.getElementsByTagName('form')[0];
        var questionLists = formEl.querySelectorAll('.question-list');

        formEl.addEventListener('submit', function (event) {
            var isValid = true;

            for (var i = 0, len = questionLists.length; i < len; i++) {
                if (!hasChecked(questionLists[i])) {
                    setErrorStatus(questionLists[i]);

                    isValid = false;
                }
            }

            if (!isValid) {
                event.returnValue = false;
                return false;
            }
        });
    }

    //function setClickEventForAllRadios() {
    //    var radios = document.querySelectorAll('[type="radio"]');
	//
    //    for (var i = 0, len = radios.length; i < len; i++) {
    //        radios[i].addEventListener('', function (event) {
	//
    //        })
    //    }
    //}

    function init() {
        setValidation();

        //setClickEventForAllRadios();

        makeRowSelect();
    }

    init();
})
();
