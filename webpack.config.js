var path = require('path');
var webpack = require('webpack');

module.exports = {
  entry: [
    "webpack-dev-server/client?http://0.0.0.0:8080",
    'webpack/hot/only-dev-server',
    './src/scripts/index'
  ],
  devtool: "eval",
  debug: true,
  output: {
    path: path.join(__dirname, "public"),
    filename: 'bundle.js'
  },
  resolveLoader: {
    modulesDirectories: ['node_modules']
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin()
  ],
  resolve: {
    extensions: ['', '.js', '.cjsx', '.coffee'],
    alias: {
      'app': path.join(__dirname, 'src/scripts')
    }
  },
  module: {
    loaders: [
      { test: /\.css$/, loaders: ['style', 'css']},
      { test: /\.cjsx$/, loaders: ['react-hot', 'coffee', 'cjsx']},
      { test: /\.coffee$/, loader: 'coffee' },
      {
        test: /\.(eot|woff2?|ttf|svg)$/,
        loader: 'file',
        include: path.join(__dirname, 'assets/fonts')
      },
      {
        test: /\.(png|jpg|jpeg|gif)$/,
        loader: 'file?name=[path][name]___[hash:base64:5].[ext]',
        include: path.join(__dirname, 'assets/img')
      }
    ]
  }
};
