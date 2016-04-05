var flight = require('flight');

function getOptions(items) {
    return _.map(items, function(item) {
        return '<option value="' + item + '">' + item + '</option>';
    });
}

var MONTH_SHORT = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
var now = new Date();
var currentYear = now.getFullYear();
var currentMonth = now.getMonth();
var YEAR_ARRAY = _.range(currentYear, currentYear - 3, -1);
var ALL_MONTH_OPTIONS = getOptions(MONTH_SHORT);
var YEAR_OPTIONS = getOptions(YEAR_ARRAY);

var MONTH_SELECT = [
    '<select class="month-picker" data-no-trigger-dialog="true">',
        ALL_MONTH_OPTIONS.join(''),
    '</select>'
].join('');

var YEAR_SELECT = [
    '<select class="year-picker" data-no-trigger-dialog="true">',
    YEAR_OPTIONS.join(''),
    '</select>'
].join('');

function MonthYearPicker() {
    this._initMonthYearPicker = function () {
        var me = this;

        this.$monthSelect = $(MONTH_SELECT)
            .appendTo(this.$node)
            .hide()
            .selectmenu({
                open: function () {
                    me._toggleMonthMenuItems(me.$yearSelect.val());
                }
            });

        this.$yearSelect = $(YEAR_SELECT)
            .appendTo(this.$node)
            .hide()
            .selectmenu({
                select: function () {
                    me._checkMonthInYear(me.$yearSelect.val(), me.$monthSelect.val());
                }
            });

        this.$monthSelect
            .selectmenu('widget')
            .addClass('month-picker-selectmenu');

        this.$yearSelect
            .selectmenu('widget')
            .addClass('year-picker-selectmenu');
    };

    this._toggleMonthMenuItems = function (year) {
        var items = this.$monthSelect.selectmenu('menuWidget').children();

        if (year === currentYear + '') {
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
    };

    this._checkMonthInYear = function (year, month) {
        if (year === currentYear + '' && MONTH_SHORT.indexOf(month) > currentMonth) {
            this.$monthSelect
                .val(MONTH_SHORT[0])
                .selectmenu('refresh');
        }
    };

    this.val = function () {
        return '{0}, {1}'.format(this.$monthSelect.val(), this.$yearSelect.val());
    };

    this.after('initialize', function () {
        this._initMonthYearPicker();
    });

    this.before('teardown', function () {
        this.$monthSelect.selectmenu('destroy');
        this.$yearSelect.selectmenu('destroy');
    });
}

module.exports = flight.component(MonthYearPicker);
