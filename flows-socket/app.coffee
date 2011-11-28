express = require "express"
redis   = require "redis"
socket  = require "socket.io"
url     = require "url"
queries = require "./lib/queries"

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

app.get "/", (req, res) ->
  res.redirect "http://liquidsoap.fm/flows.html"

app.get "/radio", (req, res) ->
  name    = req.query.name
  website = req.query.website

  queries.radio name, website, (ans, err) ->
    return res.send("An error occured while processing your request", 500) if err?

    return res.send "No such radio", 404 unless ans?

    res.header "Access-Control-Allow-Origin", "*"
    res.contentType "json"
    res.end JSON.stringify ans

app.get "/radios", (req, res) ->
  queries.radios (ans, err) ->
    return res.send("An error occured while processing your request", 500) if err?

    res.header "Access-Control-Allow-Origin", "*"
    res.contentType "json"
    res.end JSON.stringify ans

# io configuration

io = socket.listen app

io.configure "production", ->
  io.enable "browser client etag"
  io.set "log level", 1
  io.set "transports", ["xhr-polling"]
  io.set "polling duration", 10

io.sockets.on "connection", (socket) ->
  socket.on "join", (data) ->
    socket.join "#{data}"
    socket.emit "joined", data

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
  io.sockets.in("flows").emit "flows", message

  # Specific broadcast
  msg = JSON.parse(message)
  if msg.data? and msg.data.id?
    io.sockets.in("#{msg.data.id}").emit "#{msg.data.id}", message

