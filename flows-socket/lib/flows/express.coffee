express        = require "express"
express.assets = require "connect-assets"

module.exports.app = app = express.createServer()

port = parseInt process.env.PORT or 6000
app.listen port, ->
  console.log "Listening on port " + app.address().port + "."

logFormat = ":remote-addr :method :url (:status) took :response-time ms."
app.use express.logger logFormat

app.configure "production", ->
  process.addListener "uncaughtException", (err) ->
    console.error "Uncaught exception: #{err}"

app.use express.static "public"

app.use express.assets
  buildDir       : "tmp"
  buildFilenamer : (file) -> file

app.set "view engine", "eco"

app.get "/", (req, res) ->
  res.redirect "http://liquidsoap.fm/flows.html"
