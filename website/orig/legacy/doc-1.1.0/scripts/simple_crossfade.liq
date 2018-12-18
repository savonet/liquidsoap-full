# A simple (long) cross-fade
def crossfade(a,b)
  add(normalize=false,
	  [ sequence([ blank(duration=5.),
	               fade.initial(duration=10.,b) ]),
	    fade.final(duration=10.,a) ])
end

# Partially apply next to give it a jingle source.
# It will fade out the old source, then play the jingle.
# At the same time it fades in the new source.
def next(j,a,b)
  add(normalize=false,
	  [ sequence(merge=true,
	             [ blank(duration=3.),
	               fade.initial(duration=6.,b) ]),
	    sequence([fade.final(duration=9.,a),
	              j,fallback([])]) ])
end

# A similar transition,
# which does a cross-fading from A to B
# and adds a jingle
def transition(j,a,b)
  add(normalize=false,
	  [ fade.initial(b),
	    sequence(merge=true,
	            [blank(duration=1.),j,fallback([])]),
	    fade.final(a) ])
end
