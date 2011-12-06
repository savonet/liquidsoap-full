redis = require "redis"
url   = require "url"

redisUrl = process.env.REDISTOGO_URL or "redis://localhost:6379"
redisUrl = url.parse redisUrl

connect = ->
  client = redis.createClient redisUrl.port, redisUrl.hostname

  if redisUrl.auth?
    password = redisUrl.auth.split(":")[1]
    client.auth password if password?

  return client

module.exports = client = connect()

client.subscribe "flows"

