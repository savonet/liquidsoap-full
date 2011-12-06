pg = require "pg"

url = process.env.DATABASE_URL or "postgres://localhost:7778/flows"
client = new pg.Client url
client.connect()

clean = (data) ->
  fn = (label) ->
    delete data[label] unless data[label]?
  fn label for label of data
  delete data.radio_id

module.exports.streams = streams = (id, fn) ->
  query = client.query "SELECT * FROM streams WHERE radio_id = $1", [parseInt id]
  ans = []
  query.on "row", (row) ->
    clean row
    ans.push row

  query.on "end", ->
    fn ans, null

  query.on "error", (err) ->
    fn null, err

module.exports.metadata = metadata = (id, fn) ->
  query = client.query "SELECT * FROM metadatas WHERE radio_id = $1 LIMIT 1", [parseInt id]

  query.on "row", (row) ->
    fn row, null

  query.on "error", (err) ->
    fn null, err

cleanRadio = (radio) ->
  # Remove user id and last_seen
  delete radio.user_id
  delete radio.last_seen
  clean radio

sortRadios = (radios) ->
  sort = (a, b) ->
    x = a.name.toLowerCase()
    y = b.name.toLowerCase()
    if x < y then -1 else (if x > y then 1 else 0)
  radios.sort sort

radioFromSql = (sql, args, fn) ->
  query = client.query sql, args

  ans = []

  query.on "row", (radio) ->
    ans.push radio

  query.on "end", ->
    radio = ans.pop()
    return fn radio, null unless radio?

    metadata radio.id, (meta, err) ->
      return fn null, err if err?

      radio.title  = meta.title
      radio.artist = meta.artist

      streams radio.id, (streams, err) ->
        return fn null, err if err?

        radio.streams = streams
        
        cleanRadio radio
        fn radio, null

  query.on "error", (err) ->
    fn null, err

module.exports.radio = (name, website, fn) ->
  sql   = "SELECT * FROM radios WHERE name = $1"
  args = [name]
  if website?
    sql += " AND website = $2"
    args.push website

  sql += " LIMIT 1"

  radioFromSql sql, args, fn

module.exports.radioById = (id, fn) ->
  sql = "SELECT * FROM radios WHERE id = $1 LIMIT 1"
  args = [id]

  radioFromSql sql, args, fn

module.exports.radios = (fn) ->
  sql   = "SELECT * FROM radios WHERE last_seen >= (CURRENT_TIMESTAMP - interval '1' day)"
  query = client.query sql
  ans = []

  query.on "row", (radio) ->
    ans.push radio

  query.on "end", ->
    return fn ans, null if ans.length == 0
    
    radios = []
    error  = false

    enhance = (radio) ->
      return if error

      metadata radio.id, (meta, err) ->
        error = err?
        return fn null, err if err?

        # Remove user id
        delete radio.user_id

        radio.title  = meta.title
        radio.artist = meta.artist

        streams radio.id, (streams, err) ->
          error = err?
          return fn null, err if err?

          radio.streams = streams
          
          cleanRadio radio
          radios.push radio

          if radios.length == ans.length
            sortRadios radios
            fn radios, null

    enhance radio for radio in ans

  query.on "error", (err) ->
    fn null, err
