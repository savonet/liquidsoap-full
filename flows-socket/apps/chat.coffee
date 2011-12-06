_     = require "underscore"
{io}  = require "lib/flows/io"
{app} = require "lib/flows/express"

chat = io.of "/chat"

app.get "/chat", (req, res) ->
  res.render "chat.eco"

nicknames = {}
rooms = {}

leaveRoom = (room, socket) ->
  room = "#{room}"

  if not socket.rooms[room]?
    return socket.emit "error", "You have not joined that room!"

  socket.leave room
  delete socket.rooms[room]

  rooms[room] = _.without rooms[room], socket.nickname

  socket.emit "left", "#{room}"

chat.on "connection", (socket) ->
  socket.rooms = {}
  
  socket.on "nickname", (nick) ->
    return socket.emit "error", "Nickname taken!" if nicknames[nick]?

    return socket.emit "error", "Nickname already set!" if socket.nickname?

    nicknames[nick] = socket.nickname = nick

    socket.on "disconnect", ->
      return unless socket.nickname?
      delete nicknames[socket.nickname]
      
      leaveRoom room, socket for room of socket.rooms

    socket.emit "nicknamed", nick

  socket.on "join", (room) ->
    if not socket.nickname?
      return socket.emit "error", "You must set a nickname first!"
   
    room = "#{room}"
    
    if socket.rooms[room]?
      return socket.emit "error", "You have already joined that room!"
    
    socket.join room
    socket.rooms[room] = room

    rooms[room] or= []
    rooms[room].push socket.nickname

    chat.to(room).json.emit "joined",
      room:      "#{room}"
      occupants: rooms[room]

  socket.on "leave", (room) ->
    room = "#{room}"
   
    if not socket.rooms[room]?
      return socket.emit "error", "You have not joined that room!"
    
    socket.leave room
    delete socket.rooms[room]

    rooms[room] = _.without rooms[room], socket.nickname

    socket.emit "left", "#{room}"

  socket.on "chat", (msg) ->
    {room, type, data} = msg
    room = "#{room}"
    type = "#{type}"
    if not room? and type == "message"
      return socket.emit "error", "Invalid chat message"

    if not socket.rooms[room]?
      return socket.emit "error", "You have not joined that chat room"

    chat.to(room).json.emit "chat",
      type   : type
      room   : room
      origin : socket.nickname
      data   : data
