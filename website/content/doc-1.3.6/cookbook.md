Cookbook
========
The recipes show how to build a source with a particular feature. You can try short snippets by wrapping the code in an `out(..)` operator and passing it directly to liquidsoap:

```
liquidsoap -v 'out(recipe)'
```

For longer recipes, you might want to create a short script:

```
#!/usr/bin/liquidsoap -v

set("log.file.path","/tmp/<script>.log")
set("log.stdout",true)

recipe = # <fill this>
out(recipe)
```

See the [quickstart guide](quick_start.html) for more information on how to run [Liquidsoap](index.html), on what is this `out(..)` operator, etc.

Files
-----
A source which infinitely repeats the same URI:

```
single("/my/default.ogg")
```

A source which plays a playlist of requests -- a playlist is a file with an URI per line.

```
# Shuffle, play every URI, start over.
playlist("/my/playlist.txt")
# Do not randomize
playlist(mode="normal", "/my/pl.m3u")
# The playlist can come from any URI,
# can be reloaded every 10 minutes.
playlist(reload=600,"http://my/playlist.txt")
```

When building your stream, you'll often need to make it unfallible. Usually, you achieve that using a fallback switch (see below) with a branch made of a safe `single` or `playlist.safe`. Roughly, a single is safe when it is given a valid local audio file. A `playlist.safe` behaves just like a playlist but will check that all files in the playlist are valid local audio files. This is quite an heavy check, you don't want to have large safe playlists.

Transcoding
-----------
[Liquidsoap](index.html) can achieve basic streaming tasks like transcoding with ease. You input any number of ``source'' streams using `input.http`, and then transcode them to any number of formats / bitrates / etc. The only limitation is your hardware: encoding and decoding are both heavy on CPU. Also keep in mind a limitation inherent to OCaml: one [Liquidsoap](index.html) instance can only use a single processor or core. You can easily work around this limitation by launching multiple [Liquidsoap](index.html) instances, and thus take advantage of that 8-core Xeon server laying around in the dust in your garage.

```
# Input the stream,
# from an Icecast server or any other source
url = "http://streaming.example.com:8000/your-stream.ogg"
input = mksafe(input.http(url))

# First transcoder: MP3 32 kbps
# We also degrade the samplerate, and encode in mono
# Accordingly, a mono conversion is performed on the input stream
output.icecast(
  %mp3(bitrate=32, samplerate=22050, stereo=false),
  mount="/your-stream-32.mp3",
  host="streaming.example.com", port=8000, password="xxx",
  mean(input))
# Second transcoder : MP3 128 kbps
output.icecast(
  %mp3(bitrate=128), 
  mount="/your-stream-128.mp3",
  host="streaming.example.com", port=8000, password="xxx",
  input)
```

Re-encoding a file
------------------
As a simple example using a fallible output, we shall consider
re-encoding a file.
We start by building a source that plays our file only once.
That source is obviously fallible.
We pass it to a file output, which has to be in fallible mode.
We also disable the `sync` parameter on the source's clock,
to encode the file as quickly as possible.
Finally, we use the `on_stop` handler to shutdown
liquidsoap when streaming is finished.

```
# The input file,
# any format supported by liquidsoap
input = "/tmp/input.mp3"

# The output file
output = "/tmp/output.ogg"

# A source that plays the file once
source = once(single(input))

# We use a clock with disabled synchronization
clock.assign_new(sync=false,[source])

# Finally, we output the source to an
# ogg/vorbis file
output.file(%vorbis, output,fallible=true,
                     on_stop=shutdown,source)
```

Scheduling
----------
```
# A fallback switch
fallback([playlist("http://my/playlist"),
          single("/my/jingle.ogg")])
# A scheduler,
# assuming you have defined the night and day sources
switch([ ({0h-7h}, night), ({7h-24h}, day) ])
```

Force a file/playlist to be played at least every XX minutes
------------------------------------------------------------
It can be useful to have a special playlist that is played at least every 20 minutes for instance (3 times per hour).
You may think of a promotional playlist for instance.
Here is the recipe:

```
# (1200 sec = 20 min)
timed_promotions = delay(1200.,promotions)
main_source = fallback([timed_promotions,other_source])
```

Where promotions is a source selecting the file to be promoted.

Handle special events: mix or switch
------------------------------------
```
# Add a jingle to your normal source
# at the beginning of every hour:
add([normal,switch([({0m0s},jingle)])])
```

Switch to a live show as soon as one is available. Make the show unavailable when it is silent, and skip tracks from the normal source if they contain too much silence.

```
stripped_stream = 
  strip_blank(input.http("http://myicecast:8080/live.ogg"))
fallback(track_sensitive=false,
         [stripped_stream,skip_blank(normal)])
```

Without the `track_sensitive=false` the fallback would wait the end of a track to switch to the live. When using the blank detection operators, make sure to fine-tune their `threshold` and `length` (float) parameters.

Unix interface, dynamic requests
--------------------------------
Liquidsoap can create a source that uses files provided by the result of the execution of any arbitrary function of your own.
This is explained in the documentation for [request-based sources](request_sources.html).

For instance, the following snippet defines a source which repeatedly plays the first valid URI in the playlist:

```
request.dynamic(
  { request.create("bar:foo",
      indicators=
        get_process_lines("cat "^quote("playlist.pls"))) })
```

Of course a more interesting behaviour is obtained with a more interesting program than ``cat''.

Another way of using an external program is to define a new protocol which uses it to resolve URIs. `add_protocol` takes a protocol name, a function to be used for resolving URIs using that protocol. The function will be given the URI parameter part and the time left for resolving -- though nothing really bad happens if you don't respect it. It usually passes the parameter to an external program, that's how we use [bubble](bubble.html) for example:

```
add_protocol("bubble",
  fun (arg,delay) ->
    get_process_lines("/usr/bin/bubble-query "^quote(arg)))
```

When resolving the URI `bubble:artist="seed"`, liquidsoap will call the function, which will call `bubble-query 'artist="seed"'` which will output 10 lines, one URI per line.

Dynamic input with harbor
-------------------------
The operator `input.harbor` allows you to receive a source stream directly inside a running liquidsoap.

It starts a listening server on where any Icecast2-compatible source client can connect. When a source is connected, its input if fed to the corresponding source in the script, which becomes available.

This can be very useful to relay a live stream without polling the Icecast server for it.

An example can be:

```
# Serveur settings
set("harbor.bind_addr","0.0.0.0")

# An emergency file
emergency = single("/path/to/emergency/single.ogg")

# A playlist
playlist = playlist("/path/to/playlist")

# A live source
live = input.harbor("live",port=8080,password="hackme")

# fallback
radio = fallback(track_sensitive=false,
                 [live,playlist,emergency])

# output it
output.icecast(%vorbis, radio,mount="test",host="host")
```

This script, when launched, will start a local server, here bound to ``0.0.0.0''. This means that it will listen on any IP address available on the machine for a connection coming from any IP address. The server will wait for any source stream on mount point ``/live'' to login.
Then if you start a source client and tell it to stream to your server, on port 8080, with password ``hackme'', the live source will become available and the radio will stream it immediately.

Adding new commands
-------------------
You can add more commands to interact with your script through telnet or the server socket.

For instance, the following code, available in the standard API, attaches a `source.skip` command 
to a source. It is useful when the original source do not have a built-in skip command.

```
# Add a skip function to a source
# when it does not have one
# by default
def add_skip_command(s) =
 # A command to skip
 def skip(_) =
   source.skip(s)
   "Done!"
 end
 # Register the command:
 server.register(namespace="#{source.id(s)}",
                 usage="skip",
                 description="Skip the current song.",
                 "skip",skip)
end

# Attach a skip command to the source s:
add_skip_command(s)
```

Dump a stream into segmented files
----------------------------------
It is sometimes useful (or even legally necessary) to keep a backup of an audio
stream. Storing all the stream in one file can be very impractical. In order to
save a file per hour in wav format, the following script can be used:

```
# A source to dump
# s = ...

# Dump the stream
file_name = '/archive/$(if $(title),"$(title)","Unknown archive")-%Y-%m-%d/%Y-%m-%d-%H_%M_%S.mp3'
output.file(%mp3,filename,s)
```

This will save your source into a `mp3` file with name specified by `file_name`.
In this example, we use [string interpolation](language.html) and time litterals to generate a different
file name each time new metadata are coming from `s`.

Manually dump a stream
----------------------
You may want to dump the content of 
a stream. The following code adds 
two server/telnet commands, `dump.start <filename>`
and `dump.stop` to dump the content of source s
into the file given as argument

```
# A source to dump
# s = (...) 

# A function to stop
# the current dump source
stop_f = ref (fun () -> ())
# You should make sure you never
# do a start when another dump
# is running.

# Start to dump
def start_dump(file_name) =
  # We create a new file output
  # source
  s = output.file(%vorbis,
            fallible=true,
            on_start={log("Starting dump with file #{file_name}.ogg")},
            reopen_on_metadata=false,
            "#{file_name}",
            s)
  # We update the stop function
  stop_f := fun () -> source.shutdown(s)
end

# Stop dump
def stop_dump() =
  f = !stop_f
  f ()
end

# Some telnet/server command
server.register(namespace="dump",
                description="Start dumping.",
                usage="dump.start <filename>",
                "start",
                fun (s) ->  begin start_dump(s) "Done!" end)
server.register(namespace="dump",
                description="Stop dumping.",
                usage="dump.stop",
                "stop",
                fun (s) -> begin stop_dump() "Done!" end)
```

Transitions
-----------
There are two kinds of transitions. Transitions between two different children of a switch are not problematic. Transitions between different tracks of the same source are more tricky, since they involve a fast forward computation of the end of a track before feeding it to the transition function: such a thing is only possible when only one operator is using the source, otherwise it'll get out of sync.

### Switch-based transitions
The switch-based operators (`switch`, `fallback` and `random`) support transitions. For every child, you can specify a transition function computing the output stream when moving from one child to another. This function is given two `source` parameters: the child which is about to be left, and the new selected child. The default transition is `fun (a,b) -> b`, it simply relays the new selected child source. Other possible transition functions:

```
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
```

Finally, we build a source which plays a playlist, and switches to the live show as soon as it starts, using the `transition` function as a transition. At the end of the live, the playlist comes back with a cross-fading.

```
fallback(track_sensitive=false,
         transitions=[ crossfade, transition(jingle) ],
         [ input.http("http://localhost:8000/live.ogg"),
           playlist("playlist.pls") ])
```

### Cross-based transitions
The `cross()` operator allows arbitrary transitions between tracks of a same source. Here is how to use it in order to get a cross-fade:

```
def crossfade(~start_next,~fade_in,~fade_out,s)
  s = fade.in(duration=fade_in,s)
  s = fade.out(duration=fade_out,s)
  fader = fun (a,b) -> add(normalize=false,[b,a])
  cross(duration=start_next,fader,s)
end
my_source =
  crossfade(start_next=1.,fade_out=1.,fade_in=1.,my_source)
```

The `crossfade()` function is already in liquidsoap. Unless you need a custom one, you should never have to copy the above example. It is implemented in the scripting language, much like this example. You can find its code in `utils.liq`.

The fade-in and fade-out parameters indicate the duraction of the fading effects. The start-next parameters tells how much overlap there will be between the two tracks. If you want a long cross-fading with a smaller overlap, you should use a sequence to stick some blank section before the beginning of `b` in `fader`.
The three parameters given here are only default values, and will be overriden by values coming from the metadata tags `liq_fade_in`, `liq_fade_out` and `liq_start_next`.

For an advanced crossfading function, you can see the [smart crossfade documentation](smartcrossfade.html)

### How to get transitions on a mix?
If you `add()` a special source on top of your normal stream, you might notice that the re-normalization is not smooth at all: if the special source suddenly becomes available, the normal one will be re-normalized immediately, which is not very nice to hear, especially if the special source starts with a low noise level. The `add()` operator does not support transitions but there is a solution for this kind of situation. Use a `fallback()` in order to get transitions, and simply keep playing the normal source in the transition. Here is the code.

```
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
```

The first transition is used when the special source becomes available. It sums the special source (after a delay `d`) together with a reduced version of `normal` (`c(p,normal)`) and its faded-out complement (`c(q,normal)`). As a result the amplitude of `normal` will smoothly move from `1=p q` down to `p`.

The second transition is called when `special` becomes unavailable. This time, the reduced version of `normal` is mixed with its faded-in complement.

Alsa unbuffered output 
-----------------------
You can use [Liquidsoap](index.html) to capture and play through alsa with a minimal delay. This particulary useful when you want to run a live show from your computer. You can then directly capture and play audio through external speakers without delay for the DJ !

This configuration is not trivial since it relies on your hardware. Some hardware will allow both recording and playing at the same time, some only one at once, and some none at all.. Those note to configure are what works for us, we don't know if they'll fit all hardware.

First launch liquidsoap as a one line program

```
liquidsoap -v --debug 'input.alsa(bufferize=false)'
```

Unless you're lucky, the logs are full of lines like the following:

```

Could not set buffer size to 'frame.size' (1920 samples), got 2048.
```

The solution is then to fix the captured frame size to this value, which seems specific to your hardware. Let's try this script:

```
# Set correct frame size:
set("frame.audio.size",2048)

input = input.alsa(bufferize=false)
output.alsa(bufferize=false,input)
```

If everything goes right, you may hear on your output the captured sound without any delay ! If you want to test the difference, just run the same script with `bufferize=true` (or without this parameter since it is the default). The setting will be acknowledged in the log as follows:

```

Targetting 'frame.audio.size': 2048 audio samples = 2048 ticks.
```

If you experience problems it might be a good idea to double the value of the frame size. This increases stability, but also latency.


