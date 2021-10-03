list    = playlist("~/playlist")
default = single("~/default.ogg")

s = fallback([list,default])
s = amplify(1.,override="replay_gain",s)

# Here: other effects, and finally the output...
