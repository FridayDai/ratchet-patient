/**
* Created by Brittany on 1/15/15.
*/
(function ($, undefined) {
    'use strict';
    var listHeight = $("#collapse-list").height();

    /**
     * Get the height of question list when resizing window.
     */
    function _dynamicHeight() {
        $(window).on("resize", function() {
            var changeHeight = $("#collapse-list").height();
            if(changeHeight > 0) {
                listHeight = changeHeight;
            }
        });
    }

    /**
     * Collapse question list on browser content page.
     */
    function _collapseList() {
        $("#collapse-icon, #collapse-arrow").on("click", function() {
            var list = $("#collapse-list");
            var parent = $(this).parents(".block");

            if(parent.hasClass("open")) {
                parent.removeClass("open").addClass("close");
            } else {
                parent.removeClass("close").addClass("open");
            }

            if(list.height() === 0) {
                list.animate({
                    height: listHeight,
                    opacity: 1
                }, 500, function() {});
            }
            if(list.height() > 0) {
                list.animate({
                    height: 0,
                    opacity: 0.3
                }, 500, function() {});
            }
        });
    }

    /**
     * Page initialization
     * @private
     */
    function _init() {
        _dynamicHeight();
        _collapseList();
    }

    _init();

})(jQuery);
