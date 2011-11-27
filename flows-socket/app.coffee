express = require "express"
redis   = require "redis"
socket  = require "socket.io"
url     = require "url"

# Express configuration

app = express.createServer()

port = parseInt process.env.PORT or 6000
app.listen port, ->
  console.log "Listening on port " + app.address().port + "."

logFormat = ":remote-addr :method :url (:status) took :response-time ms."
app.use express.logger logFormat

app.use express.static "public"

app.configure "production", ->
  process.addListener "uncaughtException", (err) ->
    console.error "Uncaught exception: #{err}"

# io configuration
io = socket.listen app

io.sockets.on "connection", (socket) ->
  socket.on "join", (data) ->
    socket.join "#{data}"

# Redis configuration

redisURL    = process.env.REDISTOGO_URL or "redis://localhost:6379"
redisURL    = url.parse redisURL
redisClient = redis.createClient redisURL.port, redisURL.hostname

if redisURL.auth?
  password = redisURL.auth.split(":")[1]
  redisClient.auth password if password?

redisClient.subscribe "flows"

# Now the event loop.

redisClient.on "message", (channel, message) ->
  # Generic broadcast
  io.sockets.in("flows").volatile.emit "flows", message

  # Specific broadcast
  msg = JSON.parse(message)
  if msg.data? and msg.data.id?
    io.sockets.in("#{msg.data.id}").volatile.emit "#{msg.data.id}", message

