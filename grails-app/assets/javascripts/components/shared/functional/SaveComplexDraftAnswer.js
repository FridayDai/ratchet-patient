var URLs = require('../../../constants/Urls');

function SaveComplexDraftAnswer() {
    this.saveDraftAnswer = function () {
        $.ajax({
            url: URLs.SAVE_DRAFT_ANSWER.format(this.taskId),
            type: 'POST',
            data: {
                code: this.code,
                complex: JSON.stringify(this.draftAnswer)
            }
        });
    };
}

module.exports = SaveComplexDraftAnswer;
