_ = require 'lodash'

SampleComponent = React.createClass
  getInitialState: ->
    {}

  saySomething : ->
    @props.saySomething @_chatInput.value
    @_chatInput.value = ''

  saySomething2 : ->
    @props.saySomething2 @_chatInput.value
    @_chatInput.value = ''
  
  renderMessages : (messages)->
    _.map messages, (v, index)->
      <div key={index}>
        {v}
      </div>

  render : ->
    <div>
      <h5>message 1 </h5>
      {@renderMessages(@props.messages)}
      <h5>message 2 </h5>
      {@renderMessages(@props.messages2)}
      <input type='text' ref={ (ref)=>@_chatInput = ref}/>
      <button onClick={@saySomething}> send </button>
      <button onClick={@saySomething2}> send2 </button>
    </div>

################################################################################
{ connect } = require 'app/util/redux'
Actions = require 'app/actions'
module.exports = connect SampleComponent, [Actions.Sample, Actions.Sample2], (state) ->
  console.log state
  {
    messages: state.sample.messages
    messages2: state.sample2.messages
  }

################################################################################
