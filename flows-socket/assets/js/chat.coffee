class Chat
  constructor: (@opts) ->
    @url = @opts.url || "http://flows.liquidsoap.fm/chat"
    @socket = io.connect @url

    @socket.on "error",     @onError
    @socket.on "joined",    @onJoined
    @socket.on "left",    @onLeft
    @socket.on "nicknamed", @onNick
    @socket.on "chat",      @onChat

  rooms: {}

  onError: (err) => @opts.onError err if @opts.onError?

  onJoined: (room) =>
    @rooms[room] = true
    @opts.onJoined room if @opts.onJoined?
 
  onLeft: (room) =>
    delete @rooms[room]
    @opts.onLeft room if @opts.onLeft?

  onNick: (@nickname) =>
    @opts.onNick @nickname if @opts.onNick?
    
  onChat: (data) =>
    @opts.onChat data if @opts.onChat?

  requestNickname: (nickname) =>
    @socket.emit "nickname", nickname
  
  joinRoom: (room) =>
    @socket.emit "join", room

  leaveRoom: (room) =>
    @socket.emit "leave", room

  say: (room, msg) =>
    @socket.json.emit "chat",
      type : "message"
      room : room
      data : msg

window.Chat = Chat
