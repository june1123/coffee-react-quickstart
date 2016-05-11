Types = require './actionTypes'
_ = require 'lodash'

module.exports = {
  saySomething2 : (message) ->
    (dispatch) =>
      dispatch {type:Types.SAY_SOMETHING_2, message : message}
}
