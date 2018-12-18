# Mixes two streams, with faded transitions between the state when only the
# normal stream is available and when the special stream gets added on top of
# it.
# @category Source / Track Processing
# @param ~delay   Delay before starting the special source.
# @param ~p       Portion of amplitude of the normal source in the mix.
# @param ~normal  The normal source, which could be called the carrier too.
# @param ~special The special source.
def smooth_add(~delay=0.5,~p=0.2,~normal,~special)
  d = delay
  fade.final = fade.final(duration=d*2.)
  fade.initial = fade.initial(duration=d*2.)
  q = 1. - p
  c = amplify
  fallback(track_sensitive=false,
           [special,normal],
           transitions=[
             fun(normal,special)->
               add(normalize=false,
                   [c(p,normal),
                    c(q,fade.final(type="sin",normal)),
                    sequence([blank(duration=d),c(q,special)])]),
             fun(special,normal)->
               add(normalize=false,
                   [c(p,normal),
                    c(q,fade.initial(type="sin",normal))])
           ])
end
