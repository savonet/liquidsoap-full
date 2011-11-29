redis = require "redis"
url   = require "url"

redisUrl = process.env.REDISTOGO_URL or "redis://localhost:6379"
redisUrl = url.parse redisUrl

module.exports.connect = ->
  client = redis.createClient redisUrl.port, redisUrl.hostname

  if redisUrl.auth?
    password = redisUrl.auth.split(":")[1]
    client.auth password if password?

  return client
