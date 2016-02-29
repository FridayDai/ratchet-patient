require('../../../libs/MobileSelectMenu');

var flight = require('flight');
var snap = require('snapsvg');
var Notifications = require('../../common/Notification');

function PainPercentPanel() {
    this.attributes({
        painChoiceSelector: "#no-pain-choice",
        painToggleSelector: '#no-pain-toggle',
        selectMenuSelector: '.select-menu',
        resultNumberSelector: '#all-result-tip',
        resultScoreSelector: '#select-percent-score',
        resultCircle: '#result-circle',
        resultTip: '#result-tip',
        resultSubTip: '#result-sub-tip'
    });

    this.clearAllErrorStatus = function () {
        _.each($('.question-list-special'), function (question) {
            if ($(question).hasClass('error')) {
                $(question)
                    .removeClass('error')
                    .find('.error-label')
                    .remove();
            }
        });
    };

    this.clearErrorStatus = function () {
        var question = $('#pain-percent-question');
        if ($(question).hasClass('error')) {
            $(question)
                .removeClass('error')
                .find('.error-label')
                .remove();
        }
    };

    this.initSelectMenuButtonText = function () {
        this.select('selectMenuSelector').selectmenu("option", "defaultButtonText", "- -");
    };

    this.initResult = function () {
        var resultScore = snap(this.attr.resultScoreSelector);
        var resultCircle = snap(this.attr.resultCircle);

        this.clearResultError();

        resultCircle.removeClass('circle-error');
        resultCircle.attr({
            strokeDasharray: 0 + ' ' + 100
        });

        resultScore.attr({text: '0%'});
        if (resultScore.hasClass('text-start')) {
            resultScore.removeClass('text-start').addClass('text-middle');
        }
    };

    this.resultSuccess = function () {
        var $question = this.select('resultNumberSelector');
        $question.removeClass('error').addClass('success');

        this.select('resultTip').text('Great!');
        snap(this.attr.resultCircle).removeClass('circle-error').addClass('circle-doing');

        //fixed for ie.
        snap(this.attr.resultCircle).attr({
            strokeDasharray: 101 + ' ' + 100
        });
    };

    this.clearResultError = function () {
        this.select('resultNumberSelector').removeClass('error success');
        snap(this.attr.resultCircle).removeClass('circle-error circle-doing');
        this.select('resultTip').text('');
        this.select('resultSubTip').text('');
    };

    this.addResultError = function (score) {

        var $question = this.select('resultNumberSelector');
        if (!$question.hasClass('error')) {
            $question.removeClass('success').addClass('error');
        }

        if (score === 0) {
            snap(this.attr.resultCircle).removeClass('circle-error circle-doing');
            return;
        }

        if (score > 100) {
            snap(this.attr.resultCircle).removeClass('circle-doing').addClass('circle-error');
            this.select('resultTip').text('Too much!');
            this.select('resultSubTip').text('Please take out ' + (score - 100) + '%.');
            return;
        }

        if(score > 0 && score < 100) {
            snap(this.attr.resultCircle).removeClass('circle-error').addClass('circle-doing');
            this.select('resultTip').text('Add more!');
            this.select('resultSubTip').text('');
        }
    };

    this.toggleSelectMenu = function (toggle) {
        if (toggle.checked) {
            this.select('selectMenuSelector').selectmenu("disable");
            this.clearResultError();
            this.clearAllErrorStatus();
            this.initResult();
            this.initSelectMenuButtonText();
        } else {
            this.select('selectMenuSelector').selectmenu("enable");
        }
    };

    this.menuHasSelected = function () {
        var allSelect = this.select('selectMenuSelector');
        var valid = false;

        _.forEach(allSelect, function (ele) {
            if ($(ele).find('option:selected').length !== 0) {
                valid = true;
            }
        });
        return valid;
    };

    this.togglePainChartAndSelect = function (e, data) {
        var toggle = this.select('painToggleSelector').get(0);
        var selectedCheck = this.menuHasSelected();

        if (data.active === true || selectedCheck) {
            this.showNoPainNotification(toggle);
        } else {
            this.trigger('toggleAllHumanBody', toggle);
            this.toggleSelectMenu(toggle);

            this.triggerPainPercentSelectSuccess(
                'noPain',
                toggle.checked ? 1 : 0
            );
        }
    };

    this.showNoPainNotification = function (toggle) {
        var me = this;

        Notifications.confirm({
            title: 'Are you sure?',
            message: 'Enabling this checkbox will clear the answers above'
        }, {
            buttons: [
                {
                    text: 'Go back',
                    click: function () {
                        $(this).dialog("close");
                        me.select('painToggleSelector').prop('checked', false);
                    }
                },
                {
                    text: 'I have no pain',
                    'class': 'btn-agree',
                    click: function () {
                        // Warning dialog close
                        $(this).dialog("close");
                        me.trigger('toggleAllHumanBody', toggle);
                        me.toggleSelectMenu(toggle);

                        me.triggerPainPercentSelectSuccess(
                            'noPain',
                            toggle.checked ? 1 : 0
                        );
                    }
                }
            ]
        });
    };

    this.askForActiveStatus = function () {
        this.trigger('painActiveCheckRequest');
    };

    this.initSelectMenu = function () {
        var self = this;

        this.select('selectMenuSelector').selectmenu({
            width: 70,
            defaultButtonText: '- - ',
            select: function (e, ui) {
                self.sumScore();

                self.triggerPainPercentSelectSuccess(
                    $(this).attr('name').replace('choices.', ''),
                    ui.item.value
                );
            }
        });
    };

    this.triggerPainPercentSelectSuccess = function (question, answer) {
        this.trigger('painPercentSelectSuccess', {
            question: question,
            answer: answer
        });
    };

    this.sumScore = function () {
        var score = 0;
        var result = snap(this.attr.resultScoreSelector);

        _.forEach(this.select('selectMenuSelector'), function (element) {
            score = score + Number($(element).val());
        });

        //sum the score
        result.attr({text: score + '%'});
        snap(this.attr.resultCircle).attr({
            strokeDasharray: score + ' ' + 100
        });

        //adjust the text
        if (score > 0 && score < 100) {
            if (result.hasClass('text-middle')) {
                result.removeClass('text-middle').addClass('text-start');
            }
        } else if (result.hasClass('text-start')) {
            result.removeClass('text-start').addClass('text-middle');
        }

        //turn to state error or success
        if (score === 100) {
            this.clearErrorStatus();

            this.clearResultError();
            this.resultSuccess();
        } else {
            this.addResultError(score);
        }
    };

    this.checkMenuKeys = function (data) {
        return _.any(this.$node.data('percentageKeys'), function (key) {
            return key in data;
        });
    };

    this.onInitDraftAnswer = function (e, data) {
        if (data.noPain) {
            this.select('painToggleSelector').prop('checked', true);
            this.toggleSelectMenu({checked: true});
        } else if (this.checkMenuKeys(data.draft)) {
            this.sumScore();
        }
    };

    this.forPainChoiceClick = function (e) {
        var $target = $(e.target);

        var checkBox = this.select('painToggleSelector');
        var checked = checkBox.prop('checked');
        checkBox.prop('checked', !checked);
        if (!$target.is('input.rc-choice-hidden')) {
            this.trigger('painActiveCheckRequest');
        }

    };

    this.after('initialize', function () {
        this.initSelectMenu();

        this.on(this.attr.painChoiceSelector, 'click', {
            painChoiceSelector: this.forPainChoiceClick
        });

        this.on(document, 'painActiveCheckResponse', this.togglePainChartAndSelect);
        this.on(document, 'initDraftAnswer', this.onInitDraftAnswer);
    });

}

module.exports = flight.component(PainPercentPanel);


