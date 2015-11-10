require('../components/common/initSetup');
require('../components/layout/Main');

var flight = require('flight');
var WithPage = require('../components/common/WithPage');
var Task = require('../components/shared/functional/Task');
var ChartPanel = require('../components/task/painChart/HumanSvg');
var SymptomDialog = require('../components/task/painChart/SymptomDialog');
var PainPercentPanel = require('../components/task/painChart/PainPercentPanel');

function painChartTask() {

    this.attributes({
        chartPanelSelector: '#draw-board',
        symptomDialogSelector: '#symptom-choice-dialog',
        painPercentSelector: '#pain-percent-question'
    });

    this.children({
        chartPanelSelector: ChartPanel,
        painPercentSelector: PainPercentPanel
    });

    this.dialogs([
        {
            selector: 'symptomDialogSelector',
            event: 'showSymptomDialog',
            dialog: SymptomDialog
        }
    ]);

}
flight.component(Task, WithPage, painChartTask).attachTo('#main');
