var flight = require('flight');

function taskAlreadyComplete(){
    this.attributes({
        OkLinkSelector: '#ok-link'
    });

    this.initLogoLink = function () {
        $(this.attr.OkLinkSelector).attr('href', window.location.href);
    };

    this.after('initialize', function () {
        this.initLogoLink();
    });
}

flight.component(taskAlreadyComplete).attachTo('#main');
