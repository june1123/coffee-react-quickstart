{
  createStore,
  applyMiddleware,
  compose
} = require 'redux'

thunk = require('redux-thunk').default
rootReducer = require 'app/reducers'
module.exports = (initialState) ->
  store = createStore( rootReducer, initialState, applyMiddleware(thunk) )
  if module.hot
    # Enable Webpack hot module replacement for reducers
    module.hot.accept 'app/reducers', ()=>
      nextRootReducer = require 'app/reducers'
      store.replaceReducer(nextRootReducer)
    
  return store