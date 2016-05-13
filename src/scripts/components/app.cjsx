{ Component, PropTypes } = React = require 'react'
{ connect } = require 'react-redux'

Link = require('react-router').Link
RouteHandler = require('react-router').RouteHandler

# Provides global navigation for app e.g. the "Hello | Styleguide" at the top.
module.exports = React.createClass
  render: ->
    {state, dispatch, children} = @props

    <div>
      { children and React.cloneElement(children, { state, dispatch }) }
    </div>
