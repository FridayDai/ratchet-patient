require("jquery-ui-selectmenu");

var MONTH_SHORT = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
var now = new Date();
var currentYear = now.getFullYear();
var currentMonth = now.getMonth();
var YEAR_ARRAY = _.range(currentYear, currentYear - 3, -1);
var ALL_MONTH_OPTIONS = getOptions(MONTH_SHORT);
var YEAR_OPTIONS = getOptions(YEAR_ARRAY);

var MONTH_YEAR_SELECTS = [
    '<select class="month-picker">',
        ALL_MONTH_OPTIONS.join(''),
    '</select>',
    '<select class="year-picker">',
        YEAR_OPTIONS.join(''),
    '</select>'
].join('');

$.widget( "ui.monthyearpicker", {
    _create: function() {
        this.widgetId = this.element.uniqueId().attr( "id" );

        this._drawWidget();

        this.$addDatePopup =
            $(ADD_DATE_POPUP)
                .hide()
                .appendTo($addDate);

        this.$yearSelect = this.$addDatePopup
            .find('select')
            .last()
            .selectmenu({
                select: function(e) {
                    var $target = $(e.target);
                    var items = me.$monthSelect.selectmenu('menuWidget').children();

                    if ($target.val() === currentYear + '') {
                        _.each(items, function(item, index) {
                            if (index > currentMonth) {
                                $(item).addClass('ui-state-disabled');
                            }
                        });
                    } else {
                        _.each(items, function(item) {
                            $(item).removeClass('ui-state-disabled');
                        });
                    }
                }
            });

        this.$monthSelect = this.$addDatePopup
            .find('select')
            .first()
            .selectmenu();


        this.$monthSelect.selectmenu('widget').addClass('month-picker-selectmenu');
        this.$yearSelect
            .selectmenu('widget')
            .addClass('year-picker-selectmenu')
            .trigger('select');
    },

    _drawWidget: function () {
        this.$element = $(MONTH_YEAR_SELECTS).appendTo(this.element);
        this.$yearSelect = this.$element.find('select').last();
    }
});
