bitly   = require "lib/flows/bitly"
pg      = require "lib/flows/pg"
twitter = require "lib/flows/twitter"
redis   = require "lib/flows/redis"

# One update every 3 min..
updateTimeout = 3*60*1000
latestUpdate = new Date()

# Allow first update
latestUpdate.setTime latestUpdate.getTime() - updateTimeout

redis.on "message", (channel, message) ->
  now = new Date()
  return if latestUpdate? and latestUpdate.getTime() + updateTimeout > now.getTime()
 
  latestUpdate = now

  msg = JSON.parse(message)

  if msg.data.id? and msg.cmd == "metadata"
    pg.radioById msg.data.id, (radio, err) ->
      return console.error "DB error: #{err}" if err?

      # Reject metadata without title.
      return unless msg.data.title?

      metadata = if msg.data.artist? then "#{msg.data.title} by #{msg.data.artist}" else msg.data.title

      status = "On #{radio.name}: #{metadata}"

      getUrl = (fn) ->
        if radio.website?
          bitly radio.website, (shortUrl, err) ->
            if err?
              console.error "Bit.ly error: #{err}"
            
            return fn "" if err? or not shortUrl?
            
            fn " #{shortUrl}"

        else
          fn ""

      params = {}

      if radio.longitude? and radio.latitude?
        lat = parseInt radio.latitude
        long = parseInt radio.longitude
        params.coordinates = [lat, long]

      getUrl (url) ->
        # End length is: url.length + " #savonetflows".length
        endLen = url.length + 14

        if status.length + endLen > 140
          # We cut the status and add ".."
          len = 140 - endLen - 2
          status = "#{status.slice 0, len}.."

        status = "#{status} #savonetflows#{url}"

        twitter.updateStatus status, (err, data) ->
          console.error "Error while updating twitter status: #{err}" if err?
