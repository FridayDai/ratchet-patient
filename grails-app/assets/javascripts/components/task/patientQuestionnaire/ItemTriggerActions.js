var Utility = require('../../../utils/Utility');

function ItemTriggerActions() {
    this.triggerShowAction = function ($target) {
        if (!$target.is(':visible')) {
            $target.velocity('transition.slideDownIn');
        }
    };

    this.triggerHideAction = function ($target) {
        if ($target.is(':visible')) {
            $target.velocity('transition.slideUpOut');
        }
    };

    this.triggerEnableAction = function ($target) {
        if ($target.is('select')) {
            $target.selectmenu('option', 'disabled', false);
        } else if ($target.is('[type=text], textarea')) {
            $target.prop('disabled', false);
        } else if ($target.is('[type=checkbox]')) {
            $target
                .parent()
                .removeClass('disabled');
        } else if ($target.is('.multi-date-container')) {
            this.enableMultipleDate($target);
        } else {
            $target.removeClass('disabled')
                .find('[type=text], textarea')
                .prop('disabled', false);
        }
    };

    this.triggerDisableAction = function ($target) {
        if ($target.is('select')) {
            $target
                .selectmenu('option', 'disabled', true)
                .selectmenu('option', 'defaultButtonText', null)
                .val(0);

            this.clearInvolvedFieldsInDraft($target);
        } else if ($target.is('[type=text], textarea')) {
            $target.prop('disabled', true);

            this.clearInvolvedFieldsInDraft($target);
        } else if ($target.is('[type=checkbox]')) {
            $target
                .prop('checked', false)
                .parent()
                .addClass('disabled');

            this.clearInvolvedFieldsInDraft($target);
        } else if ($target.is('.multi-date-container')) {
            this.disableMultipleDate($target);

            this.clearInvolvedFieldsInDraft($target.parent().find('[type=hidden]'));
        } else {
            $target.addClass('disabled')
                .find('[type=text], textarea')
                .prop('disabled', true);

            this.clearInvolvedFieldsInDraft($target.find('[type=text], textarea'));
        }
    };

    this.triggerClearOtherInputsAction = function ($target, $currentItem) {
        if ($target.length > 1) {
            _.each($target, function (elem) {
                var $elem = $(elem);

                if ($currentItem.has(elem).length === 0) {
                    $elem.val('');

                    this.clearInvolvedFieldsInDraft($elem);
                }
            }, this);
        } else {
            $target.val('');
            this.clearInvolvedFieldsInDraft($target);
        }
    };

    this.triggerDisableOtherInputsAction = function ($target, $currentItem) {
        if ($target.length > 1) {
            _.each($target, function (elem) {
                var $elem = $(elem);

                if ($currentItem.has(elem).length === 0) {
                    $elem
                        .prop('disabled', true)
                        .val('');

                    this.clearInvolvedFieldsInDraft($elem);
                } else {
                    $elem
                        .prop('disabled', false);
                }
            }, this);
        } else {
            $target
                .prop('disabled', true)
                .val('');

            this.clearInvolvedFieldsInDraft($target);
        }
    };

    this.triggerResetAction = function ($target) {
        if ($target.length > 1) {
            _.each($target, function (elem) {
                this.resetElement($(elem));
            }, this);
        } else {
            this.resetElement($target);
        }
    };

    this.triggerMobileHideSelectAction = function ($target) {
        var $selectMenuButton;

        if (Utility.isMobile()) {
            $selectMenuButton = $target.selectmenu('widget');

            $selectMenuButton.hide();
        }
    };

    this.triggerMobileShowSelectAtOwnAction = function ($target, $currentItem) {
        var $selectMenuButton;

        if (Utility.isMobile()) {
            $selectMenuButton = $target.selectmenu('widget');

            $currentItem.append($selectMenuButton);
            $selectMenuButton.show();
        }
    };

    this.disableMultipleDate = function ($multipleDate) {
        $multipleDate.parent().find('[type=hidden]').val('');

        this.trigger('rc.mkeMultipleDatePickerDisable', {
            element: $multipleDate
        });
    };

    this.enableMultipleDate = function ($multipleDate) {
        this.trigger('rc.mkeMultipleDatePickerEnable', {
            element: $multipleDate
        });
    };

    this.resetElement = function ($elem) {
        if ($elem.hasClass('disabled')) {
            $elem.removeClass('disabled');
        }

        if ($elem.is('[type=text], textarea')) {
            $elem.val('');

            this.clearInvolvedFieldsInDraft($elem);
        } else if ($elem.is('[type=radio]')) {
            $elem.prop('checked', false);
            this.clearInvolvedFieldsInDraft($elem);
        } else if ($elem.is('select')) {
            $elem.selectmenu('option', 'defaultButtonText', null);
            this.clearInvolvedFieldsInDraft($elem);
        } else {
            this.clearInvolvedFieldsInDraft($elem.find('[type=text], textarea, [type=radio]:checked'));

            $elem
                .find('[type=text], textarea')
                .val('')
                .end()
                .find('[type=radio]')
                .prop('checked', false);
        }
    };

    this.clearInvolvedFieldsInDraft = function ($elems) {
        _.each($elems, function (elem) {
            var elementName = $(elem).attr('name');

            if (elementName) {
                var questionId = elementName.replace('choices.', '');

                delete this.draftAnswer[questionId];
            }
        }, this);
    };
}

module.exports = ItemTriggerActions;
