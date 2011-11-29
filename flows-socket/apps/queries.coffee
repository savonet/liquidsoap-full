{app} = require "lib/flows/express"
pg    = require "lib/flows/pg"

app.get "/radio", (req, res) ->
  name    = req.query.name
  website = req.query.website

  pg.radio name, website, (ans, err) ->
    return res.send("An error occured while processing your request", 500) if err?

    return res.send "No such radio", 404 unless ans?

    res.header "Access-Control-Allow-Origin", "*"
    res.contentType "json"
    res.end JSON.stringify ans

app.get "/radios", (req, res) ->
  pg.radios (ans, err) ->
    return res.send("An error occured while processing your request", 500) if err?

    res.header "Access-Control-Allow-Origin", "*"
    res.contentType "json"
    res.end JSON.stringify ans
