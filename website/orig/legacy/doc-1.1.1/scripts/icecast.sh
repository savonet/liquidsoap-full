liquidsoap 
  'output.icecast(%vorbis,
     host = "localhost", port = 8000, \
     password = "hackme", mount = "liq.ogg", \
     mksafe(playlist("playlist.m3u")))'
