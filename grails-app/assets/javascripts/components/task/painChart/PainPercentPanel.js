var flight = require('flight');
var MobileSelectMenu = require('../../shared/components/MobileSelectMenu');
var Notifications = require('../../common/Notification');

function PainPercentPanel() {
    this.attributes({
        painToggleSelector: '#no-pain-toggle',
        selectMenuSelector: '.select-menu',
        resultNumberSelector: '#select-percent-number',
        resultScoreSelector: '#select-percent-score'
    });

    this.clearErrorStatus = function () {
        var $question = $('#pain-percent-question');

        if ($question.hasClass('error')) {
            $question
                .removeClass('error')
                .find('.error-label')
                .remove();
        }
    };

    this.initSelectMenuButtonText = function () {
        this.select('selectMenuSelector').selectmenu("option", "defaultButtonText", "- -");
    };

    this.initResult = function () {
        var $question = this.select('resultNumberSelector');
        $question.removeClass('error success');
        $question.find('span').text('-');
    };

    this.clearResultError = function () {
        var $question = this.select('resultNumberSelector');
        if ($question.hasClass('error')) {
            $question.removeClass('error').addClass('success');
        }
    };

    this.addResultError = function () {
        var $question = this.select('resultNumberSelector');
        if (!$question.hasClass('error')) {
            $question.removeClass('success').addClass('error');
        }
    };

    this.toggleSelectMenu = function (toggle) {
        if (toggle.checked) {
            this.select('selectMenuSelector').selectmenu("disable");
            this.clearResultError();
            this.clearErrorStatus();
            this.initResult();
            this.initSelectMenuButtonText();
        } else {
            this.select('selectMenuSelector').selectmenu("enable");
        }
    };

    this.togglePainChartAndSelect = function (e, data) {
        var toggle = this.select('painToggleSelector').get(0);

        if (data.active === true) {
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
            title: 'ARE YOU SURE?',
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

        _.forEach(this.select('selectMenuSelector'), function (element) {
            score = score + Number($(element).val());
        });


        this.select('resultScoreSelector').text(score);

        if (score === 100) {
            this.clearResultError();
            this.clearErrorStatus();
        } else {
            this.addResultError();
        }
    };

    this.onInitDraftAnswer = function (e, data) {
        if (data.noPain) {
            this.select('painToggleSelector').prop('checked', true);
            this.toggleSelectMenu({checked: true});
        } else {
            this.sumScore();
        }
    };

    this.after('initialize', function () {
        this.initSelectMenu();

        this.on('change', {
            painToggleSelector: this.askForActiveStatus
        });

        this.on(document, 'painActiveCheckResponse', this.togglePainChartAndSelect);
        this.on(document, 'initDraftAnswer', this.onInitDraftAnswer);
    });

}

module.exports = flight.component(MobileSelectMenu, PainPercentPanel);


