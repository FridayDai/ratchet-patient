var flight = require('flight');
var MobileSelectMenu = require('../../shared/components/MobileSelectMenu');

function PainPercentPanel() {
    this.attributes({
        painToggleSelector: '#no-pain-toggle',
        selectMenuSelector: '.select-menu'
    });

    this.toggleSelectMenu = function (toggle) {
        if (toggle.checked) {
            this.select('selectMenuSelector').selectmenu("disable");
        } else {
            this.select('selectMenuSelector').selectmenu("enable");
        }

    };

    this.togglePainChartAndSelect = function (e) {
        var toggle = e.target;
        this.trigger('toggleAllHumanBody', toggle);
        this.toggleSelectMenu(toggle);
    };

    this.clearErrorStatus = function () {
        var $question = $('#pain-percent-question');

        if ($question.hasClass('error')) {
            $question
                .removeClass('error')
                .find('.error-label')
                .remove();
        }
    };

    this.clearResultError = function () {
        var $question = $('#select-percent-number');
        if ($question.hasClass('error')) {
            $question.removeClass('error').addClass('success');
        }
    };

    this.addResultError = function () {
        var $question = $('#select-percent-number');
        if (!$question.hasClass('error')) {
            $question.removeClass('success').addClass('error');
        }
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
            painToggleSelector: this.togglePainChartAndSelect
        });
    });

}

module.exports = flight.component(MobileSelectMenu, PainPercentPanel);


