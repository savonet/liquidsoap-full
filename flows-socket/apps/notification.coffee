{io}  = require "lib/flows/io"
redis = require "lib/flows/redis"

client = redis.connect()

client.subscribe "flows"

client.on "message", (channel, message) ->
  # Generic broadcast
  io.sockets.in("flows").emit "flows", message

  # Specific broadcast
  msg = JSON.parse(message)
  if msg.data? and msg.data.id?
    io.sockets.in("#{msg.data.id}").emit "#{msg.data.id}", message

