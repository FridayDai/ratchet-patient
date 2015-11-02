require('../components/common/initSetup');
require('../components/layout/Main');

var flight = require('flight');
var Task = require('../components/shared/components/Task');


flight.component(Task).attachTo('#main');
