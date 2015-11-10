var flight = require('flight');
var snap = require('snapsvg');

function humanSvg() {

    this.attributes({
        armPartSelector: '.part-arm-group'
    });

    this.activeArmPattern = function (path) {
        var s = snap(this.snapSvg);

        var p = s.path("M10-5-10,15M15,0,0,15M0-5-20,15").attr({
            fill: "none",
            stroke: "#e82831",
            strokeWidth: 2
        });
        p = p.pattern(0, 0, 10, 10);

        snap(path).attr({
            fill: p
        }).removeClass('arm-part').addClass('active-arm');
    };

    this.initArmPattern = function (path) {
        snap(path).attr({
            fill: 'none'
        }).addClass('arm-part').removeClass('active-arm');
    };

    this.removeCurrentText = function (element) {
        $(element).find('g').remove();
    };

    this.addSymptomsText = function (element, data) {
        var snapElement = snap(element);
        var $ele = $(element);
        var parameter = $ele.data("parameter");
        var gx = parameter[0];
        var gy = parameter[1];
        var offset = parameter[2];

        this.removeCurrentText(element);

        for (var i = 0; i < data.length; i++) {
            var square = snapElement.rect(0, 0, 14, 14).attr({
                fill: "red"
            });
            var inlineText = snapElement.text(7, 11, data[i]).attr({
                fill: "#fff",
                "text-anchor": "middle",
                "font-size": "13px"
            });
            var x = gx + Math.floor(i % 2) * 20 + Math.floor(i / 2) * offset;
            var y = gy + Math.floor(i / 2) * 20;
            snapElement.g(square, inlineText).attr({
                transform: snap.format("tanslate({x},{y})", {x: x, y: y})
            });
        }

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
            _.forEach($('.part-arm-group'), function(ele) {
                self.removeCurrentText(ele);
            });

            _.forEach($('.active-arm'), function(ele) {
                self.initArmPattern(ele);
            });
        }
    };

    this.onArmClicked = function (e) {
        e.preventDefault();

        var self = e.target;
        this.snapSvg = $(self).closest('svg').get(0);
        this.armPart = $(self).closest('.part-arm-group').get(0);
        this.trigger('showSymptomDialog');
    };

    this.onSymptomSelectedSuccess = function (e, data) {
        var path = $(this.armPart).find('path').get(0);

        this.addSymptomsText(this.armPart, data.tags);

        if (data.tags && data.tags.length > 0) {
            this.activeArmPattern(path);
        } else {
            this.initArmPattern(path);
        }

    };

    this.after('initialize', function () {

        this.on('click', {
            armPartSelector: this.onArmClicked
        });

        this.on(document, 'symptomSelectedSuccess', this.onSymptomSelectedSuccess);

        this.on(document, 'toggleAllHumanBody', this.toggleAllHumanBody);
    });

}

module.exports = flight.component(humanSvg);
