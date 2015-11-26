require('../components/common/initSetup');
require('../components/layout/Main');

var flight = require('flight');
var Task = require('../components/shared/functional/Task');
var SaveComplexDraftAnswer = require('../components/shared/functional/SaveComplexDraftAnswer');

function nrsLikeTool() {
    this.attributes({
        questionListSelector: '.question-list'
    });

    this.initDraftAnswer = function () {
        this.draftAnswer = this.select('formSelector').data('draft') || {};
    };

    this.prepareDraftAnswer = function ($target) {
        var $questionList = $target.closest('.question-list');
        var $answer = $target.closest('.answer');
        var $hiddenRadio = $answer.find('.rc-choice-hidden');
        var index = $questionList.data('index');

        this.draftAnswer[index] = $hiddenRadio.val();

        this.saveDraftAnswer();
    };

    this.after('initialize', function () {
        this.initDraftAnswer();
    });
}

flight.component(
    SaveComplexDraftAnswer,
    Task,
    nrsLikeTool
).attachTo('#main');
