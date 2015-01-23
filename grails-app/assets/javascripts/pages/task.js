/**
* Created by Brittany on 1/15/15.
*/
(function ($, undefined) {
    'use strict';

    /**
     * Show tips on intro page.
     */
    $("#info").hover(
        function() {
            $(this).parent().parent().addClass("show-tip");
        },
        function() {
            $(this).parent().parent().removeClass("show-tip");
        }
    );

    /**
     * Collapse question list on browser content page.
     */
    var listHeight = $("#collapse-list").height();
    $("#collapse-icon").on("click", function() {
        var ele = $("#collapse-list");
        if(ele.height() === 0) {
            $("#collapse-list").animate({
                height: listHeight,
                opacity: 1
            }, 500, function() {
                $("#collapse-icon").html("—");
            });
        } else {
            $("#collapse-list").animate({
                height: 0,
                opacity: 0.3
            }, 500, function() {
                $("#collapse-icon").html("+");
            });
        }
    });

    /**
     * Collapse question list on mobile content page.
     */
    $("#collapse-arrow").on("click", function() {
        var ele = $("#collapse-list");
        if(ele.height() === 0) {
            $("#collapse-list").animate({
                height: listHeight,
                opacity: 1
            }, 500, function() {
                $("#collapse-arrow").removeClass("caret-bottom").addClass("caret-top");
            });
        } else {
            $("#collapse-list").animate({
                height: 0,
                opacity: 0.3
            }, 500, function() {
                $("#collapse-arrow").removeClass("caret-top").addClass("caret-bottom");
            });
        }
    });

})(jQuery);
