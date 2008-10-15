#!../liquidsoap/src/liquidsoap -v -d

set("log.file", false)
set("init.daemon", false)
set("server.telnet", true)

def mksafe(s)
fallback(track_sensitive = false, [s, blank()])
end

output = output.ao(id="output")

s = request.queue(id="queue")
s = amplify(interactive_float("volume", 1.),s)
s = mksafe(s)

output(s)
