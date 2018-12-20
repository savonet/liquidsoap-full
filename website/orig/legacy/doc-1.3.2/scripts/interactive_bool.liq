# Activate the telnet server
set("server.telnet",true)

# The two sources
s1 = playlist("~/Music")
s2 = sine()

# Create an interactive boolean
b = interactive.bool("button", true)

# Switch between the tracks depending on the boolean
s = switch(track_sensitive=false,[(b,s1), ({true},s2)])

# Output the result
output.pulseaudio(s)
