var webpack = require("webpack");
var CommonsChunkPlugin = require("webpack/lib/optimize/CommonsChunkPlugin");

var contextUrl = "grails-app/assets/javascripts";
var absoluteContext = __dirname + "/" + contextUrl;

module.exports = {
    devtool: 'eval',
    context: contextUrl,
    entry: {
        assist: "./pages/assist.js",
        emailConfirm: "./pages/emailConfirm.js",
        emailSetting: "./pages/emailSetting.js",
        emailCollection: "./pages/emailCollection.js",
        dashLikeTool: "./pages/dashLikeTool.js",
        koosLikeTool: "./pages/koosLikeTool.js",
        nrsLikeTool: "./pages/nrsLikeTool.js",
        odiLikeTool: "./pages/odiLikeTool.js",
        verticalChoiceTool: "./pages/verticalChoiceTool.js",
        painChartTool: "./pages/painChartTool.js"
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
            "jquery-ui-selectmenu": "bower_components/jquery-ui/ui/selectmenu.js",
            headroom: "bower_components/headroom.js/dist/headroom.js",
            "jquery-headroom": "bower_components/headroom.js/dist/jQuery.headroom.js",
            "snapsvg": "bower_components/Snap.svg/dist/snap.svg.js"
        }
    },
    module: {
        noParse: [
        ],
        loaders: [{
            test: require.resolve(absoluteContext + '/bower_components/Snap.svg/dist/snap.svg.js'),
            loader: __dirname + '/node_modules/imports-loader?this=>window,fix=>module.exports=0'
        }]
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
