Link = require('react-router').Link
_ = require 'lodash'

sendbird = require 'sendbird'
ChatMessages = require './chat-messages'

ChatLogin = React.createClass
  getInitialState: ->
    {username: ''}

  onPress: () ->
    username = @_nameInput.value
    
    sendbird.init {
      app_id: 'A7A2672C-AD11-11E4-8DAA-0A18B21C2D82'
      guest_id: username
      user_name: username
      image_url: ""
      access_token: ""
      successFunc: (data) =>
        # @props.navigator.push({ name: 'channels' })
        @props.onInitCompleted(username)
      errorFunc: (status, error) =>
        @setState {username: ''}
    }

  render: ->
    <div>
      <input type='text' ref={ (ref)=>@_nameInput = ref}/>

    <div onClick={@onPress}>Login</div>
    </div>

Channels = React.createClass
  getInitialState: ->
    {
      channelList: []
      page : 0
      next : 0
      channelName : ''
    }

  componentWillMount: ->
    @getChannelList(1)

  getChannelList: (page) ->
    if page == 0
      return

    sendbird.getChannelList {
      page: page
      limit: 20
      successFunc : (data) =>
        @setState {
          channelList: @state.channelList.concat(data.channels) 
          page: data.page
          next: data.next
        }
      errorFunc: (status, error) =>
        console.log status, error
    }

  connectSendBird : ->
    successFunc = (data) =>
      sendbird.getChannelInfo (channel) =>
        sendbird.connect {
          successFunc: (data) => 
            @props.onConnectChannel(channel)
          errorFunc: (status, error) =>
            console.log status, error
        }
    errorFunc = (status, error) =>
      console.log status, error

    sendbird.connect {
      successFunc
      errorFunc
    }

  onChannelPress : (url)->
    sendbird.joinChannel url, {
      successFunc: (data) =>
        @connectSendBird()
      errorFunc: (status, error) =>
        console.log status, error
    }        

  renderChannels : ()->
    _.map @state.channelList, (v, index)=>
      <div onClick={()=>@onChannelPress(v.channel_url)} key={index}>
        <div>{v.name} ({v.member_count})</div>
      </div>

  render : ()->
    <div>
      {@renderChannels()}
    </div>

module.exports = React.createClass
  displayName: 'HelloWorld'

  getInitialState: ->
    {
      init: false
      name : ''
      channel : null
    }
  
  loginCompleted : (name) ->
    @setState {
      init : true
      name : name
    }
  onConnectChannel : (channel) ->
    @setState { channel }

  render: ->
    <div>
      <ChatLogin onInitCompleted={@loginCompleted}/>
      { <Channels onConnectChannel={@onConnectChannel}/> if @state.init } 
      { <ChatMessages /> if @state.channel } 
    </div>
