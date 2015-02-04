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
     * Page initialization
     * @private
     */
    function _init() {
        _dynamicHeight();
    }

    _init();

})(jQuery);
