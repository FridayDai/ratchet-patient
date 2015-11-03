var flight = require('flight');
var WithChildren = require('./WithChildren');

function WithLayout() {
    flight.compose.mixin(this, [
        WithChildren
    ]);
}

module.exports = WithLayout;
