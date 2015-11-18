var flight = require('flight');
var WithDialog = require('../../common/WithDialog');

function SelectNumberDialog() {
    this.attributes({
        checkBoxGroupSelector: '.msg-center'
    });

    this.options({
        title: 'SELECT NUMBER',
        width: 320,
        buttons: [{
            text: 'Save',
            click: function () {
                this.saveNumber();
            }
        }]

    });

    this.onShow = function (e, data) {
        this.$node.removeClass('ui-hidden');
        this.prepareForShow(data);
        this.show();
    };

    this.prepareForShow = function (data) {
        this.selectId = data.id;
        this.select('checkBoxGroupSelector').find("input:checked").prop('checked', false);
    };

    this.saveNumber = function () {
        var value = this.select('checkBoxGroupSelector').find("input:checked").val() || "0";
        this.trigger('mobileSelectSuccess', {
            id: this.selectId,
            index: value/10,
            label: value
        });
        this.close();
    };

    this.after('initialize', function () {

    });


}

module.exports = flight.component(WithDialog, SelectNumberDialog);


