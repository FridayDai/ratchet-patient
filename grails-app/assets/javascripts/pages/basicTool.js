require('../components/common/initSetup');
require('../components/layout/Main');

var flight = require('flight');
var Task = require('../components/shared/functional/Task');

function BasicTool() {
    this.initWindowResize = function () {
        $(window).on('resize', _.bind(this.onWindowResize, this));

        this.onWindowResize.call(this);
    };

    this.onWindowResize = (function () {
        var $window = $(window);
        var $tables = $('table');

        $tables.each(function (index, table) {
            var $table = $(table);

            $table.data('normalLayout', {
                'bodyTrs': $table.find('tbody tr').clone()
            });
        });

        return function () {
            var me = this;
            var windowWidth = $window.width();

            if (windowWidth < 768) {
                $tables.each(function (index, table) {
                    me.oneColumnTable(table);
                });
            } else {
                $tables.each(function (index, table) {
                    me.normalizeTable(table);
                });
            }
        };
    })();

    this.oneColumnTable = function (table) {
        var $table = $(table);
        if (!$table.hasClass('one-column')) {
            if (!$table.data('oneColumnLayout')) {
                this.recordOneColumnStructure($table);
            }

            $table.find('tbody').html('')
                .append($table.data('oneColumnLayout').bodyTrs);

            $table.addClass('one-column');
        }

        $table.show();
    };

    this.recordOneColumnStructure = function ($table) {
        var $bodyTrs = $table.find('tbody tr');
        var tdSizeInTr = $bodyTrs.first().find('td').size();
        var $tds = $table.find('tbody td');
        var tdArr = [];

        for (var i = 0, j = 0; i < $tds.size(); i++, j++) {
            if (j === tdSizeInTr) {
                j = 0;
            }

            if (!tdArr[j]) {
                tdArr[j] = [];
            }

            tdArr[j].push($('<tr></tr>').append($tds.get(i)));
        }

        $table.data('oneColumnLayout', {
            'bodyTrs': _.flattenDeep(tdArr)
        });
    };

    this.normalizeTable = function (table) {
        var $table = $(table);
        if ($table.hasClass('one-column')) {
            $table.find('tbody')
                .html('')
                .append($table.data('normalLayout').bodyTrs);

            $table.removeClass('one-column');
        }
    };

    this.after('initialize', function () {
        this.initWindowResize();
    });
}

flight.component(Task, BasicTool).attachTo('#main');
