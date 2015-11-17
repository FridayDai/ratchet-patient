module.exports = {
    isMobile: function () {
        return window.innerWidth < 767;
    },

    isIE: function () {
        var ua = window.navigator.userAgent;
        var msie = ua.indexOf("MSIE ");

        return (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) ? true : false;
    }
};
