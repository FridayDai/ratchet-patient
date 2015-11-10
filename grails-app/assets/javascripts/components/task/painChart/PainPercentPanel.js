require("jquery-ui-selectmenu");
var flight = require('flight');

function PainPercentPanel() {
    this.attributes({
        painToggleSelector: '#no-pain-toggle',
        selectMenuSelector: '.select-menu'
    });

    this.toggleSelectMenu = function (toggle) {
        if(toggle.checked) {
            this.select('selectMenuSelector').selectmenu("disable");
        } else {
            this.select('selectMenuSelector').selectmenu("enable");
        }

    };

    this.togglePainChartAndSelect = function(e) {
        var toggle = e.target;
        this.trigger('toggleAllHumanBody', toggle);
        this.toggleSelectMenu(toggle);
    };

    this.after('initialize', function () {

        this.select('selectMenuSelector').selectmenu({width: 70});

        this.on('change', {
            painToggleSelector: this.togglePainChartAndSelect
        });
    });

}

module.exports = flight.component(PainPercentPanel);


