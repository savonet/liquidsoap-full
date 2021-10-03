# The transition to live1
jingle1 = single("say:And now, we present the awesome show number one!!")
to_live1 = to_live(jingle1)

# Transition to live2
jingle2 = single("say:Welcome guys, this is show two on My Awesome Radio!")
to_live2 = to_live(jingle2)

# Combine lives and files:
s = fallback(track_sensitive=false,
             transitions=[to_live1, to_live2, to_file],
             [live1, live2, s]) 
