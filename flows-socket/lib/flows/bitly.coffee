Bitly = require "bitly"

bitly = new Bitly process.env.BITLY_USER, process.env.BITLY_KEY

module.exports = (url, fn) ->
  bitly.shorten url, (err, res) ->
    return fn null, err if err?
    return fn null, new Error "Http status: #{res.status_code}" unless res.status_code == 200

    fn res.data.url, null

