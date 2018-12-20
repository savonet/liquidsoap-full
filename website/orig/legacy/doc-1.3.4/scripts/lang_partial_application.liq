out = output.icecast(%vorbis, host="streamer",port="8080",
                            password="sesame")
# out is a function waiting for the other parameters
out(bitrate=112, my_radio)
