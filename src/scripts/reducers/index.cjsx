'use strict'
{ combineReducers } = require 'redux'

sample = require 'app/actions/sample/reducer'
sample2 = require 'app/actions/sample2/reducer'

module.exports = combineReducers {
  sample
  sample2
}