set("harbor.bind_addr","0.0.0.0")

# Some code...

# This defines a source waiting on mount point 
# /test-harbor
live = input.harbor("test-harbor",port=8080,password="xxx")

# This is the final stream.
# Uses the live source as soon as available,
# and don't wait for an end of track, since 
# we don't want to cut the beginning of the live
# stream.
#
# You may insert a jingle transition here...
radio = fallback(track_sensitive=false,
                 [live,files])
