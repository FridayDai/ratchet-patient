require('../../common/WithDatepicker');

var flight = require('flight');

var DATE_CONTAINER_TEMP = '<ul class="multi-date-picker-list"></ul>';

var DATE_ITEM_TEMP = [
    '<li class="multi-date-picker-item">',
        '<span class="multi-date-picker-close">X</span>',
        '<span class="multi-date-picker-item-text">{0}</span>',
    '</li>'
].join('');

var ADD_DATE_TEMP = [
    '<span class="multi-date-picker-add">',
        '<input type="text" class="multi-date-picker-add-input"/>',
        '<span class="multi-date-picker-add-button">+ Add Date</span>',
    '</span>'
].join('');

function MultipleDatePicker() {
    this.initComponent = function () {
        this.data = [];

        this.$node
            .addClass('multi-select-date-picker')
            .append(DATE_CONTAINER_TEMP);

        var me = this;

        $(ADD_DATE_TEMP)
            .find('input')
            .datepicker({
                dateFormat: 'MM d, yy',
                onSelect: function (dateText) {
                    var $addButton = me.$node.find('.multi-date-picker-add');
                    this.fixFocusIE = true;

                    if (_.indexOf(me.data, dateText) === -1) {
                        me.data.push(dateText);

                        $(DATE_ITEM_TEMP.format(dateText))
                            .find('.multi-date-picker-close')
                            .click(function () {
                                $(this)
                                    .off('click')
                                    .closest('.multi-date-picker-item')
                                    .remove();
                            })
                            .end()
                            .insertBefore($addButton);
                    }
                }
            })
            .end()
            .click(function () {
                $(this).find('input').datepicker('show');
            }).appendTo(this.$node.find('ul'));
    };

    this.after('initialize', function () {
        this.initComponent();
    });

    this.before('teardown', function () {
        this.$node
            .find('.multi-date-picker-add')
            .off('click')
            .find('input')
            .datepicker('destroy');
    });
}

module.exports = flight.component(MultipleDatePicker);
