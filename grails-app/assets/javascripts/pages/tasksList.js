require('../components/common/initSetup');
require('../components/layout/Main');
require('velocity');

var flight = require('flight');

function tasksListPage() {
    this.attributes({
        activeTaskSelector: '#quick-filter-active',
        allTaskSelector: '#quick-filter-all',
        activeTaskListSelector: '#task-list-active',
        allTaskListSelector: '#task-list-all'
    });

    this.onAllTaskClick = function () {
        $(this.attr.activeTaskListSelector).velocity("slideUp");
        $(this.attr.allTaskListSelector).velocity("slideDown");

        $(this.attr.allTaskSelector).hide();
        $(this.attr.activeTaskSelector).show();
    };

    this.onActiveTaskClick = function () {
        $(this.attr.activeTaskListSelector).velocity("slideDown");
        $(this.attr.allTaskListSelector).velocity("slideUp");

        $(this.attr.activeTaskSelector).hide();
        $(this.attr.allTaskSelector).show();

    };

    this.after('initialize', function () {
        this.on('click', {
            activeTaskSelector: this.onActiveTaskClick,
            allTaskSelector: this.onAllTaskClick
        });
    });
}

flight.component(tasksListPage).attachTo('#main');
