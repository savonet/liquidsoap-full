# Shuffle, play every URI, start over.
playlist("/my/playlist.txt")
# Do not randomize
playlist(mode="normal", "/my/pl.m3u")
# The playlist can come from any URI,
# can be reloaded every 10 minutes.
playlist(reload=600,"http://my/playlist.txt")
