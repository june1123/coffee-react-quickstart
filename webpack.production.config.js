var path = require('path');
var webpack = require('webpack');
var _ = require('lodash');

var webpackConfig = require('./webpack.config')
webpackProductionConfig = _.cloneDeep(webpackConfig);
webpackProductionConfig.output.plugins = [
  new webpack.DefinePlugin({
      // This has effect on the react lib size.
      "process.env": {
        NODE_ENV: JSON.stringify("production")
      }
    }),
    new webpack.IgnorePlugin(/vertx/),
    new webpack.IgnorePlugin(/un~$/),
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.UglifyJsPlugin(),
];

webpackProductionConfig.devtool = 'source-map';
webpackProductionConfig.entry = {
  app: [
      './src/scripts/index'
  ],
};

module.exports = webpackProductionConfig;
// module.exports = {
//   entry: {
//     app: [
//       './src/scripts/index'
//     ],
//   },
//   devtool: 'source-map',
//   output: {
//       path: path.join(__dirname, "public"),
//       filename: "bundle.js",
//   },
//   resolveLoader: {
//     modulesDirectories: ['..', 'node_modules']
//   },
//   plugins: [
//     new webpack.DefinePlugin({
//       // This has effect on the react lib size.
//       "process.env": {
//         NODE_ENV: JSON.stringify("production")
//       }
//     }),
//     new webpack.IgnorePlugin(/vertx/),
//     new webpack.IgnorePlugin(/un~$/),
//     new webpack.optimize.DedupePlugin(),
//     new webpack.optimize.UglifyJsPlugin(),
//   ],
//   resolve: {
//     extensions: ['', '.js', '.cjsx', '.coffee']
//   },
//   module: {
//     loaders: [
//       { test: /\.css$/, loaders: ['style', 'css']},
//       { test: /\.cjsx$/, loaders: ['coffee', 'cjsx']},
//       { test: /\.coffee$/, loader: 'coffee' }
//     ]
//   }
// };
