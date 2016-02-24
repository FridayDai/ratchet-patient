var flight = require('flight');
var snap = require('snapsvg');

var color = {
    white: '#fff',
    gray: '#e6e6e6'
};

function PainDrawingBoard() {

    this.attributes({
        bodyPartSelector: '.part-group',
        svgResultGroupSelector: '#svg-choice-result'
    });

    this.addSymptomsBars = function (path) {
        snap(path).addClass('active-part');
    };

    this.clearErrorStatus = function ($question) {
        $question = $($question);

        if ($question.hasClass('error')) {
            $question
                .removeClass('error')
                .find('.error-label')
                .remove();
        }
    };

    this.removeSymptomsBars = function (path) {
        snap(path).removeClass('active-part');
    };

    this.removeSymptomsText = function (element) {
        $(element).find('g.symptoms-text').remove();
    };

    this.addSymptomsText = function (element, data) {
        var snapElement = snap(element);
        var $ele = $(element);
        var parameter = $ele.data("parameter");
        var gx = parameter[0];
        var gy = parameter[1];
        var offset = parameter[2] || 0;
        var rowLength = parameter[3] || 2;

        this.removeSymptomsText(element);

        for (var i = 0; i < data.length; i++) {
            var square = snapElement.rect(0, 0, 13, 13).attr({
                fill: "red"
            });
            var inlineText = snapElement.text(7, 11, data[i]).attr({
                fill: "#fff",
                "text-anchor": "middle",
                "font-size": "12px"
            });
            var x = gx + Math.floor(i % rowLength) * 16 + Math.floor(i / rowLength) * offset;
            var y = gy + Math.floor(i / rowLength) * 18;
            snapElement.g(square, inlineText).attr({
                transform: snap.format("tanslate({x},{y})", {x: x, y: y})
            }).addClass('symptoms-text');
        }
    };

    this.removeAllInputValue = function () {
        _.forEach(this.select('svgResultGroupSelector').find('.active'), function(ele) {
            $(ele).removeClass('active').val('');
        });
    };

    this.changeInputValue = function (path, value) {
        var resultClass = "#{0}-hidden".format(path.id);

        if (value && value.length > 0) {
            this.select('svgResultGroupSelector').find(resultClass).addClass('active').val(value);
        } else {
            this.select('svgResultGroupSelector').find(resultClass).removeClass('active').val(value);
        }
    };

    this.checkAllInputValue = function () {
        return  this.select('svgResultGroupSelector').find('.active').length > 0;
    };

    this.toggleAllHumanBody = function(e, toggle) {
        var self = this;

        _.forEach($('.human'), function(svg) {
            var s = snap(svg);
            if(toggle.checked) {
                s.addClass('disabled');

                _.forEach($.merge($('.body'), ($('.part-direction'))), function(ele) {
                    snap(ele).attr({
                        fill: color.gray
                    });
                });

                $.merge($('.stroke'), $('.indication')).hide();
            } else {
                s.removeClass('disabled');

                _.forEach($.merge($('.body'), ($('.part-direction'))), function(ele) {
                    snap(ele).attr({
                        fill: color.white
                    });
                });

                $.merge($('.stroke'), $('.indication')).show();
            }
        });

        if(toggle.checked) {
            _.forEach($('.part-group'), function(ele) {
                self.removeSymptomsText(ele);
            });

            _.forEach($('.active-part'), function(ele) {
                self.removeSymptomsBars(ele);
            });

            self.removeAllInputValue();
        }
    };

    this.onBodyPartClicked = function (e) {
        e.preventDefault();

        var self = e.target;
        //this.snapSvg = $(self).closest('svg').get(0);
        this.humanPart = $(self).closest('.part-group');
        var id = this.humanPart.find('[class^=human-part]').get(0).id;
        var eleId = "#{0}-hidden".format(id);
        var checkedTags = this.select('svgResultGroupSelector').find(eleId).val();

        this.trigger('showSymptomDialog', {tags: checkedTags, bodyName: id});
    };

    this.onSymptomSelectedSuccess = function (e, data) {
        var path = this.humanPart.find('[class^=human-part]').get(0);
        this.changeInputValue(path, data.tags);

        if (data.tags && data.tags.length > 0) {
            this.addSymptomsToChart(data.bodyName, data.tags);
            this.clearErrorStatus('#pain-drawing-board');
        } else {
            this.removeSymptomsFromChart(data.bodyName);
        }
    };

    this.addSymptomsToChart = function (bodyName, tags) {
        var $bodyPath = $('#{0}'.format(bodyName));
        var $bodyGroup = $bodyPath.closest('.part-group');

        this.addSymptomsBars($bodyPath.get(0));
        this.addSymptomsText($bodyGroup.get(0), tags);
    };

    this.removeSymptomsFromChart = function (bodyName) {
        var $bodyPath = $('#{0}'.format(bodyName));
        var $bodyGroup = $bodyPath.closest('.part-group');

        this.removeSymptomsBars($bodyPath.get(0));
        this.removeSymptomsText($bodyGroup.get(0));
    };

    this.onCheckActiveStatus = function () {
        var result = this.checkAllInputValue();
        this.trigger('painActiveCheckResponse', {active: result});
    };

    this.onInitDraftAnswer = function (e, data) {
        var me = this;

        if (data.noPain) {
            this.toggleAllHumanBody(null, {checked: true});
        } else {
            _.each(data.chartChoices, function (item) {
                if (item[1]) {
                    me.snapSvg = $('#{0}'.format(item[0])).closest('svg').get(0);
                    me.addSymptomsToChart(item[0], item[1].split(','));
                    $('#{0}-hidden'.format(item[0])).addClass('active');
                }
            });
        }
    };

    this.after('initialize', function () {

        this.on('click', {
            bodyPartSelector: this.onBodyPartClicked
        });

        this.on(document, 'painActiveCheckRequest', this.onCheckActiveStatus);
        this.on(document, 'symptomSelectedSuccess', this.onSymptomSelectedSuccess);
        this.on(document, 'toggleAllHumanBody', this.toggleAllHumanBody);
        this.on(document, 'initDraftAnswer', this.onInitDraftAnswer);
    });

}

module.exports = flight.component(PainDrawingBoard);
