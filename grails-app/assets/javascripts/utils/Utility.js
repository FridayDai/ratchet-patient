var IS_OLD_IE = window.navigator.userAgent.indexOf("MSIE ") > 0;

module.exports = {
    isMobile: function () {
        return window.innerWidth < 767;
    },

    isIE: function () {
        var ua = window.navigator.userAgent;
        var msie = ua.indexOf("MSIE ");

        return (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) ? true : false;
    },

    isOldIE: function () {
        return IS_OLD_IE;
    },

    hideProcessing: function () {
        var $process = $("#rc-patient-msg-process");

        if ($process.length > 0) {
            $process.hide();
        }
    },

    checkArraySelfRun: function (items, fn, scope) {
        if (_.isArray(items)) {
            _.each(items, function (item) {
                fn.call(scope, item);
            }, scope);
        } else {
            fn.call(scope, items);
        }
    }
};
