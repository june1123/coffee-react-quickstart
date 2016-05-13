React = require 'react'
ReactDOM = require 'react-dom'
# Assign React to Window so the Chrome React Dev Tools will work.
window.React = React

{ Route, IndexRoute} = Router = require('react-router')

# Require route components.
HelloWorld = require 'app/components/hello_world'
StyleGuide = require 'app/components/styleguide'
App = require 'app/components/app'
Sample = require 'app/components/sample'

module.exports = (
  <Route path='/' component={ App }>
    <IndexRoute component={HelloWorld} />
    <Route component={StyleGuide} path="/styleguide" />
    <Route component={Sample} path="/sample" />
  </Route>
)
