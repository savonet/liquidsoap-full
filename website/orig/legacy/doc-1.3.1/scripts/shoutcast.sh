liquidsoap 'output.shoutcast(%mp3,
                host="localhost", port = 8000,
	        password = "changeme",
	        mksafe(playlist("playlist.m3u")))'
