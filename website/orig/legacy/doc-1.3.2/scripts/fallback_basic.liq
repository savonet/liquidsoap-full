stripped_stream = 
  strip_blank(input.http("http://myicecast:8080/live.ogg"))
fallback(track_sensitive=false,
         [stripped_stream,skip_blank(normal)])
