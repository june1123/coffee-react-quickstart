Types = require './actionTypes'
_ = require 'lodash'

module.exports = {
  saySomething : (message) ->
    (dispatch) =>
      dispatch {type:Types.SAY_SOMETHING, message : message}
}
