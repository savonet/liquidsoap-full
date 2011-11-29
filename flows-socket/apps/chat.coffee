{io} = require "lib/flows/io"

chat = io.of "/chat"

nicknames = {}

chat.on "connection", (socket) ->
  # Set nickname
  socket.on "nickname", (nick) ->
    return socket.emit "error", "Nickname taken!" if nicknames[nick]?

    delete nicknames[socket.nickname] if socket.nickname?

    nicknames[nick] = socket.nickname = nick

    socket.on "disconnect", ->
      return unless socket.nickname?
      delete nicknames[socket.nickname]

    socket.emit "nicknamed", nick

  socket.on "join", (room) ->
    return socket.emit "error", "You must set a nickname first!" unless socket.nickname?
    
    # Join chat room
    socket.join "#{room}"

    socket.emit "joined", room

    socket.on "#{room}", (msg) ->
      chat.to("#{room}").json.emit "#{room}",
        type   : "message"
        origin : socket.nickname
        data   : msg
