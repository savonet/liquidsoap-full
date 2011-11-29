{app}  = require "lib/flows/express"
socket = require "socket.io"

module.exports.io = io = socket.listen app

io.configure "production", ->
  io.enable "browser client minification"
  io.enable "browser client etag"
  io.enable "browser client gzip"
  io.set "log level", 1
  io.set "transports", ["xhr-polling"]
  io.set "polling duration", 10

io.sockets.on "connection", (socket) ->
  socket.on "join", (data) ->
    socket.join "#{data}"
    socket.emit "joined", data
