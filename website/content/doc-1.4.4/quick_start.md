Quickstart
==========
The Internet radio toolchain
----------------------------
[Liquidsoap](index.html) is a general audio stream generator, but is mainly intended for Internet radios. Before starting with the proper Liquidsoap tutorial let's describe quickly the components of the internet radio toolchain, in case the reader is not familiar with it.

The chain is made of:

* the stream generator (Liquidsoap, [ices](http://www.icecast.org/ices.php), or for example a DJ-software running on your local PC) which creates an audio stream (Ogg Vorbis or MP3);
* the streaming media server ([Icecast](http://www.icecast.org), [Shoutcast](http://www.shoutcast.com), ...) which relays several streams from their sources to their listeners;
* the media player (iTunes, Winamp, ...) which gets the audio stream from the streaming media server and plays it to the listener's speakers.

![Internet radio toolchain](images/schema-webradio-inkscape.png)The stream is always passed from the stream generator to the server, whether or not there are listeners. It is then sent by the server to every listener. The more listeners you have, the more bandwidth you need.

If you use Icecast, you can broadcast more than one audio feed using the same server. Each audio feed or stream is identified by its "mount point" on the server. If you connect to the `foo.ogg` mount point, the URL of your stream will be [http://localhost:8000/foo.ogg](http://localhost:8000/foo.ogg) -- assuming that your Icecast is on localhost on port 8000. If you need further information on this you might want to read Icecast's [documentation](http://www.icecast.org). A proper setup of a streaming server is required for running Liquidsoap.

Now, let's create an audio stream.

Starting to use Liquidsoap
--------------------------
In this tutorial we assume that you have a fully installed Liquidsoap. In particular the library `pervasives.liq` and its accompanying scripts should have been installed, otherwise Liquidsoap won't know the operators which have been defined there. If you installed into the default `/usr/local` you will find it inside `/usr/local/lib/liquidsoap/<version>`.

### Sources
A stream is built with Liquidsoap by using or creating sources. A source is an annotated audio stream. In the following picture we represent a stream which has at least three tracks (one of which starts before the snapshot), and a few metadata packets (notice that they do not necessarily coincide with new tracks).

![A stream](images/stream.png)In a Liquidsoap script, you build source objects. Liquidsoap provides many functions for creating sources from scratch (e.g. `playlist`), and also for creating complex sources by putting together simpler ones (e.g. `switch` in the following example). Some of these functions (typically the `output.*`) create an active source, which will continuously pull its children's stream and output it to speakers, to a file, to a streaming server, etc. These active sources are the roots of a Liquidsoap instance, the sources which bring life into it.

### That source is fallible!
A couple of things can go wrong in your streaming system.
In Liquidsoap,
we say that a source is *infallible* if it is always available.
Otherwise, it is *fallible*, something can go wrong.
By default, an output requires that its input source is infallible,
otherwise it complains that ``That source is fallible!''

For example, a normal `playlist` is fallible.
Firstly, because it could contain only invalid files, or at least spend too
much time on invalid files for preparing a valid one on time.
Moreover, a playlist could contain remote files, which may not
be accessible quickly at all times.
A queue of user requests is an other example of fallible source. 
Also, if `file.ogg` is a valid local file,
then `single("file.ogg")` is an infallible source.

When an output complains about its source, you have to turn it into
an infallible one. Depending on the situation, many solutions are available.
The function `mksafe` takes a source and returns an infallible
source, streaming silence when the input stream becomes unavailable.
In a radio-like stream, silence is not the prefered solution, and you
will probably prefer to `fallback` on an infallible
``security'' source:

```liquidsoap
fallback([your_fallible_source_here, single("failure.ogg")])
```

Finally, if you do not care about failures, you can pass the parameter
`fallible=true` to most outputs. In that case, the output
will accept a fallible source, and stop whenever the source fails,
to restart when it is ready to emit a stream again.
This is usually done if you are not emitting a radio-like stream,
but for example capturing or relaying another stream,
or encoding files.

One-line expressions
--------------------
Liquidsoap is a scripting language. Many simple setups can be achieved by evaluating one-line expressions.

### Playlists
In the first example we'll play a playlist. Let's put a list of audio files in 
`playlist.pls`: one filename per line, lines starting with a `#` are 
ignored. You can also put remote files' URLs, if your liquidsoap has 
[support](help.html#plugins) for the corresponding protocols.
Then just run:

```liquidsoap
liquidsoap 'out(playlist("playlist.pls"))'
```

Other playlist formats are supported, such as M3U and, depending on your
configuration, XSPF.
Instead of giving the filename of a playlist, you can also use a directory 
name, and liquidsoap will recursively look for audio files in it.

Depending on your configuration, the output `out` will use AO, Alsa or OSS, or won't do anything if you do not have support for these libs. In that case, the next example is for you.

### Streaming out to a server
Liquidsoap is capable of playing audio on your speakers, but it can also send audio to a streaming server such as Icecast or Shoutcast.
One instance of liquidsoap can stream one audio feed in many formats (and even many audio feeds in many formats!).

You may already have an Icecast server. Otherwise you can install and configure your own Icecast server. The configuration typically consists in setting the admin and source passwords, in `/etc/icecast2/icecast.xml`. These passwords should really be changed if your server is visible from the hostile internet, unless you want people to kick your source as admins, or add their own source and steal your bandwidth.

We are now going to send an audio stream, encoded as Ogg Vorbis, to an Icecast server:

```liquidsoap
liquidsoap \
  'output.icecast(%vorbis,
     host = "localhost", port = 8000,
     password = "hackme", mount = "liq.ogg",
     mksafe(playlist("playlist.m3u")))'
```

The main difference with the previous is that we used `output.icecast` instead of `out`. The second difference is the use of the `mksafe` which turns your fallible playlist source into an infallible source.

Streaming to Shoutcast is quite similar, using the `output.shoutcast` function:

```liquidsoap
liquidsoap 'output.shoutcast(%mp3,
                host="localhost", port = 8000,
	        password = "changeme",
	        mksafe(playlist("playlist.m3u")))'
```

### Input from another streaming server
Liquidsoap can use another stream as an audio source. This may be useful if you do some live shows.

```liquidsoap
liquidsoap '
  out(input.http("http://dolebrai.net:8000/dolebrai.ogg"))'
```

### Input from the soundcard
If you're lucky and have a working ALSA support, try one of these... but beware that ALSA may not work out of the box.

```liquidsoap
liquidsoap 'output.alsa(input.alsa())'
```

```liquidsoap
liquidsoap 'output.alsa(bufferize = false,
                        input.alsa(bufferize = false))'
```

### Other examples
You can play with many more examples. Here are a few more. To build your own, 
lookup the [API documentation](reference.html) to check what functions are available, and what parameters they accept.

```liquidsoap
# Listen to your playlist, but normalize the volume
liquidsoap 'out(normalize(playlist("playlist_file")))'
```

```liquidsoap
# ... same, but also add smart cross-fading
liquidsoap 'out(crossfade(
                  normalize(playlist("playlist_file"))))'
```

Script files
------------
We have seen how to create a very basic stream using one-line expressions. If you need something a little bit more complicated, they will prove uneasy to manage. In order to make your code more readable, you can write it down to a file, named with the extension `.liq` (eg: `myscript.liq`).

To run the script:

```liquidsoap
liquidsoap myscript.liq
```

On UNIX, you can also put `#!/path/to/your/liquidsoap` as the first line of your script ("shebang"). Don't forget to make the file executable:

```
chmod u+x myscript.liq
```

Then you'll be able to run it like this:

```
./myscript.liq
```

Usually, the path of the liquidsoap executable is `/usr/bin/liquidsoap`, and we'll use this in the following.

A simple radio
--------------
In this section, we build a basic radio station that plays songs randomly chosen from a playlist, adds a few jingles (more or less one every four songs), and output an Ogg Vorbis stream to an Icecast server.

Before reading the code of the corresponding liquidsoap script, it might be useful to visualize the streaming process with the following tree-like diagram. The idea is that the audio streams flows through this diagram, following the arrows. In this case the nodes (`fallback` and `random`) select one of the incoming streams and relay it. The final node `output.icecast` is an output: it actively pulls the data out of the graph and sends it to the world.

![Graph for 'basic-radio.liq'](images/basic-radio-graph.png)
```liquidsoap
#!/usr/bin/liquidsoap
# Log dir
set("log.file.path","/tmp/basic-radio.log")

# Music
myplaylist = playlist("~/radio/music.m3u")
# Some jingles
jingles = playlist("~/radio/jingles.m3u")
# If something goes wrong, we'll play this
security = single("~/radio/sounds/default.ogg")

# Start building the feed with music
radio = myplaylist
# Now add some jingles
radio = random(weights = [1, 4],[jingles, radio])
# And finally the security
radio = fallback(track_sensitive = false, [radio, security])

# Stream it out
output.icecast(%vorbis,
  host = "localhost", port = 8000,
  password = "hackme", mount = "basic-radio.ogg",
  radio)
```

What's next?
------------
You can first have a look at a [more complex example](complete_case.html). There is also a second tutorial about [advanced techniques](advanced.html).

You should definitely learn [how to get help](help.html).
If you know enough liquidsoap for your use, you'll only need to refer to the
[scripting reference](reference.html), or see the [cookbook](cookbook.html).
At some point,
you might read more about Liquidsoap's [scripting language](language.html).
For a better understanding of liquidsoap,
it is also useful to read a bit about the notions of
[sources](sources.html) and [requests](requests.html).


