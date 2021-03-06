require('../../common/WithDatepicker');

var flight = require('flight');
var Utility = require('../../../utils/Utility');
var MonthYearPicker = require('../../shared/components/MonthYearPicker');

var DATE_CONTAINER_TEMP = '<ul class="multi-date-picker-list"></ul>';

var DATE_ITEM_TEMP = [
    '<li class="multi-date-picker-item">',
        '<span class="multi-date-picker-close">X</span>',
        '<span class="multi-date-picker-item-text">{0}</span>',
    '</li>'
].join('');

var ADD_DATE_TEMP = [
    '<span class="multi-date-picker-add">',
        '<span class="multi-date-picker-add-button">+ Add Date</span>',
    '</span>'
].join('');

var ADD_DATE_POPUP = [
    '<div class="multi-date-picker-add-pop">',
        '<div class="month-year-picker"></div>',
        '<span class="add-button">+</span>',
    '</div>'
].join('');

function MultipleDatePicker() {
    this.attributes({
        disabled: false
    });

    this.initComponent = function () {
        this.data = [];

        this.$node
            .addClass('multi-select-date-picker')
            .append(DATE_CONTAINER_TEMP);

        var me = this;

        var $addDate = $(ADD_DATE_TEMP)
            .click(function () {
                if (!me.attr.disabled) {
                    if (Utility.isMobile()) {
                        me.trigger('showMultipleDateMobileDialog', {
                            $elem: me.$node
                        });
                    } else {
                        me.showAddDatePopup();
                    }
                }
            })
            .appendTo(this.$node.find('ul'));

        this.$addDatePopup =
            $(ADD_DATE_POPUP)
                .hide()
                .appendTo($addDate);

        this.monthYearPicker = MonthYearPicker.attachTo(this.$addDatePopup.find('.month-year-picker')[0]);

        this.$addDatePopup.find('.add-button').click(_.bind(this.onPopupAddButtonClicked, this));

        var init = this.$node.data('init');

        if (init) {
            _.each(init.split('&'), function (dateText) {
                this.addDate(dateText);
            }, this);
        }

        if (this.$node.data('disable')) {
            this.disable();
        }
    };

    this._documentClick = function (e) {
        e.stopPropagation();
        if (!this.$addDatePopup.is(':visible')) {
            return;
        }

        if (!$(e.target).closest(".multi-date-picker-add-pop").length &&
            !$(e.target).closest(".ui-selectmenu-menu").length
        ) {
            this.closeAddDatePopup();
        }
    };

    this.closeAddDatePopup = function () {
        this.$addDatePopup.hide();

        $(document).off('mousedown', this._documentClickBind);
    };

    this.showAddDatePopup = function () {
        this.$addDatePopup.show();

        this._documentClickBind = _.bind(this._documentClick, this);
        $(document).on('mousedown', this._documentClickBind);
    };

    this.onPopupAddButtonClicked = function(e) {
        e.stopPropagation();

        this.addDate(this.monthYearPicker.val(), true);

        this.closeAddDatePopup();
    };

    this.addDate = function (dateText, isTriggerAddEvent) {
        var me = this;
        var $addButton = this.$node.find('.multi-date-picker-add');

        if (!_.includes(this.data, dateText)) {

            this.data.push(dateText);

            $(DATE_ITEM_TEMP.format(dateText))
                .find('.multi-date-picker-close')
                .click(function () {
                    var $close = $(this);

                    $close
                        .off('click')
                        .closest('.multi-date-picker-item')
                        .remove();

                    _.remove(me.data, function (n) {
                        return n === $close.next().text();
                    });

                    me.trigger('rc.multipleDatePickerSelect', {
                        $elem: me.$node,
                        value: me.getCurrentVal($addButton)
                    });
                })
                .end()
                .insertBefore($addButton);

            if (isTriggerAddEvent) {
                me.trigger('rc.multipleDatePickerDelete', {
                    $elem: me.$node,
                    value: me.getCurrentVal($addButton)
                });
            }
        }
    };

    this.getCurrentVal = function ($elem) {
        var $dateItemText = $elem.closest('.multi-select-date-picker').find('.multi-date-picker-item-text');

        return _.reduce($dateItemText, function (result, elem) {
            result.push($(elem).text());
            return result;
        }, []).join('&');
    };

    this.onDisable = function (e, data) {
        if (data.element.get(0) === this.$node.get(0)) {
            this.disable();
        }
    };

    this.onEnable = function (e, data) {
        if (data.element.get(0) === this.$node.get(0)) {
            this.enable();
        }
    };

    this.disable = function () {
        this.$node
            .find('.multi-date-picker-item')
            .remove();

        this.attr.disabled = true;

        this.$node
            .find('.multi-date-picker-add')
            .addClass('disabled');
    };

    this.enable = function () {
        this.attr.disabled = false;

        this.$node
            .find('.multi-date-picker-add')
            .removeClass('disabled');
    };

    this.onMobileDateReturned = function (e, data) {
        if (this.$node.get(0) === data.$elem.get(0)) {
            this.addDate(data.value, true);
        }
    };

    this.after('initialize', function (elem, options) {
        this.initComponent(options);

        this.on(document, 'rc.mkeMultipleDatePickerDisable', this.onDisable);
        this.on(document, 'rc.mkeMultipleDatePickerEnable', this.onEnable);
        this.on(document, 'returnMobileMultipleDatePickerValue', this.onMobileDateReturned);
    });
}

module.exports = flight.component(MultipleDatePicker);
