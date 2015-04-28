//= require ../bower_components/jquery-validation/dist/jquery.validate

//= require ../bower_components/jquery-ui/ui/jquery.ui.core
//= require ../bower_components/jquery-ui/ui/jquery.ui.widget
//= require ../bower_components/jquery-ui/ui/jquery.ui.position
//= require ../bower_components/jquery-ui/ui/jquery.ui.tooltip

//= require ../share/constant

function shareBundle(undefined) {
    'use strict';

    var common = RC.common = RC.common || {};

    function _init() {
        _setValidator();
        _setMaintenance();
    }

    function _setMaintenance() {
        var _closeBanner = function() {
           var banner = document.getElementsByClassName("maintenance red")[0];
           banner.style.display = "none";
        };

        var button = document.getElementById("maintenance-close");
        if(button) {
            button.addEventListener("click", function() {
               //TO-DO: ajax call
               _closeBanner();
            }, false);
        }
    }

    function _setValidator() {
        $.validator.setDefaults({
            focusInvalid: false,
            showErrors: function (errorMap, errorList) {

                $.each(this.validElements(), function (index, element) {

                    var elem = $(element).parent().find('.select2-container');
                    if (elem.length > 0) {
                        RC.common.hideErrorTip(elem);
                    } else {
                        RC.common.hideErrorTip(element);
                    }
                });

                $.each(errorList, function (index, error) {
                    var elem = $(error.element).parent().find('.select2-container');
                    if (elem.length > 0) {
                        var obj = {
                            element: elem,
                            message: error.message,
                            method: error.method
                        };
                        RC.common.showErrorTip(obj);
                    } else {
                        RC.common.showErrorTip(error);
                    }
                });
            }
        });
    }

    $.extend(common, {
        /**
         * show error tip
         * @param errorElement
         * @param showType
         */
        showErrorTip: function (errorElement) {
            var element = $(errorElement.element);
            var errorMessage = errorElement.message;
            element.attr("data-error-msg", errorMessage);
            var className = "error-msg-bottom";
            if (element.is("[data-class]")) {
                className = element.attr("data-class");
            }
            var position;
            switch (className) {
                case 'error-msg-top':
                    position = {my: 'center bottom', at: 'center top-10'};
                    break;
                case 'error-msg-bottom':
                    position = {my: 'left top', at: 'left bottom'};
                    break;
                case 'error-msg-left':
                    position = {my: 'right center', at: 'left-10 center'};
                    break;
                case 'error-msg-right':
                    position = {my: 'left center', at: 'right+10 center'};
                    break;
            }
            position.collision = 'none';
            var errorContent = $('<div class="validation-error-text">' +
            '<i class="misc-icon ui-validation-error"></i>' + errorMessage + '</div>');
            var tooltips = element.tooltip({
                tooltipClass: className,
                position: position,
                items: "[data-error-msg], [title]",
                content: function () {
                    if (element.is("[data-error-msg]")) {
                        return errorContent;
                    }
                    if (element.is("[title]")) {
                        return element.attr("title");
                    }
                    return errorContent;
                }
            });
            tooltips.tooltip("open");
        },

        /**
         * hide error tip
         * @param element
         */
        hideErrorTip: function (errorElement) {
            var element = $(errorElement);
            if ($(element).tooltip()) {
                $(element).tooltip("destroy");
                $(element).removeAttr("data-error-msg");
            }
        },

        /**
         * tooltip
         */
        tooltip: function () {

        }
    });

    _init();
}

if (window.addEventListener)
    window.addEventListener("load", shareBundle, false);
else if (window.attachEvent)
    window.attachEvent("onload", shareBundle);
