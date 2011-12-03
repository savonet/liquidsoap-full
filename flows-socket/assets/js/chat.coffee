class Chat extends io.EventEmitter
  rooms : {}

  constructor: (@url = "http://flows.liquidsoap.fm/chat") ->
    @socket = io.connect @url

    @socket.on "error", (err) => @emit "error", err
  
    @socket.on "joined", (room) =>
      @rooms[room] = true
      @emit "joined", room

    @socket.on "left", (room) =>
      delete @rooms[room]
      @emit "left", room
    
    @socket.on "nicknamed", (@nickname) =>
      @emit "nicknamed", @nickname
    
    @socket.on "chat", (data) =>
      @emit "chat", data

  requestNickname: (nickname) =>
    @socket.emit "nickname", nickname
  
  joinRoom: (room) =>
    room = "#{room}"
    @socket.emit "join", room

  leaveRoom: (room) =>
    room = "#{room}"
    @socket.emit "leave", room

  say: (room, msg) =>
    @socket.json.emit "chat",
      type : "message"
      room : room
      data : msg

window.Chat = Chat
