_ = require 'lodash'
sendbird = require 'sendbird'

ChatMessages = React.createClass
  getInitialState: ->
    {
      message: ''
      messageList: []
    }

  componentWillMount : ->
    sendbird.events.onMessageReceived = (obj) =>
      @setState {
        messageList: @state.messageList.concat [obj]
      }
    @getMessages()

  componentWillUnmount: ->
    sendbird.disconnect()  

  getMessages : ->
    sendbird.getMessageLoadMore {
      limit: 100
      successFunc: (data) =>
        _messageList = []
        _.forEach data.messages.reverse(), (msg, index) =>
          if sendbird.isMessage(msg.cmd) 
            _messageList.push(msg.payload)

        @setState { 
          messageList: _messageList.concat(@state.messageList)
        }
      errorFunc: (status, error) =>
        console.log status, error
    }

  sendMessage : ->
    sendbird.message @_chatInput.value
    @_chatInput.value = ''

  renderMessages : ->
    _.map @state.messageList, (item, index) =>
      <div key={index}>
        {item.user.name} : {item.message}
      </div>
  render : ->
    <div>
      {@renderMessages()}
      <input type='text' ref={ (ref)=>@_chatInput = ref}/>
      <button onClick={@sendMessage}> send </button>
    </div>

module.exports = ChatMessages