'use strict'

{ connect } = require 'react-redux'
_ = require 'lodash'

module.exports.connect = (component, actions, mapStateToProps) ->
  actionArray = if _.isArray actions then actions else [actions]
  actionObj = _.assign.apply(this, [{}].concat actionArray)
  connect(mapStateToProps, actionObj)(component)