require('../components/layout/Main');

var flight = require('flight');
var WithPage = require('../components/common/WithPage');

var MainPanel = require('../components/emailSetting/MainPanel');
var SubscribeDialog = require('../components/emailSetting/SubscribeDialog');

function EmailSetting() {
    this.attributes({
        mainPanelSelector: 'form',
        subscribeDialogSelector: '#subscribe-dialog'
    });

    this.children({
        mainPanelSelector: MainPanel
    });

    this.dialogs([
        {
            selector: 'subscribeDialogSelector',
            event: 'showSubscribeDialog',
            dialog: SubscribeDialog
        }
    ]);
}

flight.component(WithPage, EmailSetting).attachTo('#main');
