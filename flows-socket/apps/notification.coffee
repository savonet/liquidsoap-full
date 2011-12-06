{io}  = require "lib/flows/io"
redis = require "lib/flows/redis"

# / namespace is for notifications
io.sockets.on "connection", (socket) ->
  socket.on "join", (data) ->
    socket.join "#{data}"
    socket.emit "joined", data

redis.on "message", (channel, message) ->
  msg = JSON.parse(message)

  # Generic broadcast
  io.sockets.in("flows").json.emit "flows", msg

  # Specific broadcast
  if msg.data? and msg.data.id?
    io.sockets.in("#{msg.data.id}").json.emit "#{msg.data.id}", msg

