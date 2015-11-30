var flight = require('flight');
var MobileSelectMenu = require('../../shared/components/MobileSelectMenu');
var Notifications = require('../../common/Notification');

function PainPercentPanel() {
    this.attributes({
        painToggleSelector: '#no-pain-toggle',
        selectMenuSelector: '.select-menu',
        resultNumberSelector: '#select-percent-number'
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
            select: function () {
                var score = 0;
                _.forEach($('.select-contain .select-menu'), function (element) {
                    score = score + Number($(element).val());
                });
                var result = $('#select-percent-score');
                result.text(score);
                if (score === 100) {
                    self.clearResultError();
                    self.clearErrorStatus();
                } else {
                    self.addResultError();
                }
            }
        });
    };

    this.after('initialize', function () {
        this.initSelectMenu();

        this.on('change', {
            painToggleSelector: this.askForActiveStatus
        });

        this.on(document, 'painActiveCheckResponse', this.togglePainChartAndSelect);
    });

}

module.exports = flight.component(MobileSelectMenu, PainPercentPanel);


