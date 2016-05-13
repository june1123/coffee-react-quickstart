gulp = require 'gulp'
gutil = require 'gulp-util'
webpack = require("webpack")
WebpackDevServer = require("webpack-dev-server")
webpackConfig = require("./webpack.config.js")
webpackProductionConfig = require("./webpack.production.config.js")
map = require 'map-stream'
touch = require 'touch'
_ = require 'lodash'

# Load plugins
$ = require('gulp-load-plugins')()

gulp.task('copy-assets', ->
    gulp.src('assets/**')
      .pipe(gulp.dest('public'))
      .pipe($.size())
)

gulp.task "webpack:build", (callback) ->
  # Run webpack.
  webpack webpackProductionConfig, (err, stats) ->
    throw new gutil.PluginError("webpack:build", err)  if err
    gutil.log "[webpack:build]", stats.toString(colors: true)
    callback()
    return


# Create a single instance of the compiler to allow caching.
devCompiler = webpack(webpackConfig)
gulp.task "webpack:build-dev", (callback) ->

  # Run webpack.
  devCompiler.run (err, stats) ->
    throw new gutil.PluginError("webpack:build-dev", err)  if err
    gutil.log "[webpack:build-dev]", stats.toString(colors: true)
    callback()
    return

  return

devServer = {}
gulp.task "webpack-dev-server", (callback) ->
  # Start a webpack-dev-server.
  devServer = new WebpackDevServer(webpack(webpackConfig),
    contentBase: './public/'
    hot: true
    watchOptions:
        aggregateTimeout: 100
        poll: 300
    historyApiFallback: true
    noInfo: true
  )
  devServer.listen 8080, "0.0.0.0", (err) ->
    throw new gutil.PluginError("webpack-dev-server", err) if err
    gutil.log "[webpack-dev-server]", "http://localhost:8080"
    callback()

  return

gulp.task 'default', ->
  gulp.start 'build'

gulp.task 'build', ['webpack:build', 'copy-assets']

gulp.task 'watch', ['copy-assets', 'webpack-dev-server'], ->
  gulp.watch(['assets/**'], ['copy-assets'])
