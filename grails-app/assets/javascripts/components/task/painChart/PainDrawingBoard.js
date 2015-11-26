var flight = require('flight');
var snap = require('snapsvg');

function PainDrawingBoard() {

    this.attributes({
        bodyPartSelector: '.part-group',
        svgResultGroupSelector: '#svg-choice-result'
    });

    this.addSymptomsBars = function (path) {
        var s = snap(this.snapSvg);

        var p = s.path("M10-5-10,15M15,0,0,15M0-5-20,15").attr({
            fill: "none",
            stroke: "#e82831",
            strokeWidth: 2
        });
        p = p.pattern(0, 0, 10, 10);

        snap(path)
            .attr({
                fill: p
            })
            .removeClass('human-part')
            .addClass('active-part');
    };

    this.removeSymptomsBars = function (path) {
        snap(path)
            .attr({
                fill: 'none'
            })
            .addClass('human-part')
            .removeClass('active-part');
    };

    this.removeSymptomsText = function (element) {
        $(element).find('g').remove();
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
            var square = snapElement.rect(0, 0, 14, 14).attr({
                fill: "red"
            });
            var inlineText = snapElement.text(7, 11, data[i]).attr({
                fill: "#fff",
                "text-anchor": "middle",
                "font-size": "13px"
            });
            var x = gx + Math.floor(i % rowLength) * 20 + Math.floor(i / rowLength) * offset;
            var y = gy + Math.floor(i / rowLength) * 20;
            snapElement.g(square, inlineText).attr({
                transform: snap.format("tanslate({x},{y})", {x: x, y: y})
            });
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
                _.forEach($.merge($('.body'), ($('.body-inline'))), function(ele) {
                    snap(ele).attr({
                        fill: '#E6E6E6'
                    });
                });
            } else {
                s.removeClass('disabled');
                _.forEach($('.body'), function(ele) {
                    snap(ele).attr({
                        fill: '#DFB28B'
                    });
                });
                _.forEach($('.body-inline'), function(ele) {
                    snap(ele).attr({
                        fill: '#BE966E'
                    });
                });
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
        this.snapSvg = $(self).closest('svg').get(0);
        this.humanPart = $(self).closest('.part-group').get(0);
        var id = this.humanPart.firstElementChild.id;
        var eleId = "#{0}-hidden".format(id);
        var checkedTags = this.select('svgResultGroupSelector').find(eleId).val();

        this.trigger('showSymptomDialog', {tags: checkedTags, bodyName: id});
    };

    this.onSymptomSelectedSuccess = function (e, data) {
        var path = $(this.humanPart).find('path').get(0);
        this.changeInputValue(path, data.tags);

        if (data.tags && data.tags.length > 0) {
            this.addSymptomsToChart(data.bodyName, data.tags);
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
