Action = require './actionTypes'
_ = require 'lodash'

defaultState = 
  messages: []

module.exports = (state = defaultState, action) ->
  switch action.type
    when Action.SAY_SOMETHING_2
      console.log action.message
      messages = _.clone state.messages
      messages.push action.message
      _.assign {}, state, {
        messages
      }
    else
      state