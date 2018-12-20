fallback(track_sensitive=false,
	     transitions=[ crossfade, transition(jingle) ],
	     [ input.http("http://localhost:8000/live.ogg"),
	       playlist("playlist.pls") ])
