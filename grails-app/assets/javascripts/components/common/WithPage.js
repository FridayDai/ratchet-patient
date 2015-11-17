require('../common/initSetup');

var flight = require('flight');
var WithChildren = require('./WithChildren');
var WithPageDialog = require('./WithPageDialog');

function WithPage() {
    flight.compose.mixin(this, [
        WithChildren,
        WithPageDialog
    ]);
}

module.exports = WithPage;
