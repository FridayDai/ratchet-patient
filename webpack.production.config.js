var webpack = require("webpack");
var CommonsChunkPlugin = require("webpack/lib/optimize/CommonsChunkPlugin");

var contextUrl = "grails-app/assets/javascripts";
var absoluteContext = __dirname + "/" + contextUrl;

module.exports = {
    devtool: 'source-map',
    context: contextUrl,
    entry: {
        assist: "./pages/assist.js",
        emailConfirm: "./pages/emailConfirm.js",
        emailSetting: "./pages/emailSetting.js",
        dashLike: "./pages/dashLike.js",
        koosLike: "./pages/koosLike.js",
        nrsLike: "./pages/nrsLike.js",
        odiLike: "./pages/odiLike.js",
        verticalChoice: "./pages/verticalChoice.js"
    },
    output: {
        path: absoluteContext,
        filename: "./dist/[name].bundle.js"
    },
    resolve: {
        root: absoluteContext,
        alias: {
            jquery: "bower_components/jquery/dist/jquery.js",
            lodash: "bower_components/lodash/lodash.js",
            flight: "libs/flight/index.js",
            jForm: "bower_components/jquery-form/jquery.form.js",
            "jquery-ui-dialog": "bower_components/jquery-ui/ui/dialog.js",
            "jquery-headroom": "bower_components/headroom/dist/jQuery.headroom.js"
        }
    },
    module: {
        noParse: [
        ]
    },
    plugins: [
        new webpack.ProvidePlugin({
            $: "jquery",
            _: "lodash",
            jQuery: "jquery",
            "window.jQuery": "jquery",
            "root.jQuery": "jquery"
        }),
        new CommonsChunkPlugin("./dist/commons.chunk.js")
    ]
};
