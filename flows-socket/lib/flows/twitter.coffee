twitter = require "ntwitter"

module.exports = client = new twitter
  consumer_key        : process.env.TWITTER_CONSUMER_KEY
  consumer_secret     : process.env.TWITTER_CONSUMER_SECRET
  access_token_key    : process.env.TWITTER_TOKEN_KEY
  access_token_secret : process.env.TWITTER_TOKEN_SECRET


client.verifyCredentials (err, data) ->
  if err?
    console.log "Twitter authentication error: #{err}"
  else
    console.log "Twitter authentication OK!"
