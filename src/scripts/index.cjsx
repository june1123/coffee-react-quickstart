# Import our various react tools
React = require 'react'
{ render } = require 'react-dom'
{ Provider } = require 'react-redux'
{ applyRouterMiddleware, Router, browserHistory } = require 'react-router'
useScroll = require 'react-router-scroll'

# Assign React to Window so the Chrome React Dev Tools will work.
window.React = React

# Import our store creator and routes config
store = require 'app/store'
routes = require 'app/routes'

initialState = {
  # You can add any initial state you want to app to start with here...
}

# Create our store with the initial state
initialStore = store(initialState)

# Render out the root component with the redux provider and debug panel
render(
  <div>
    <Provider store={ initialStore }>
      <Router history={browserHistory} 
        routes={ routes } 
        render={applyRouterMiddleware(useScroll())}
      />
    </Provider>
  </div>,
  document.getElementById('app')
)
