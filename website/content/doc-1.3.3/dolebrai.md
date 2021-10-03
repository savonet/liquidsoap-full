Dolebraï
=========
[Dolebraï](http://dolebrai.net) is a netradio dedicated to free music,
*i.e.* music distributed under Creative-Commons-alike licenses.
Its goal is to advertise this alternative way of distributing music
by broadcasting a selection of quality tracks:
[listen to it](http://dolebrai.net:8000/dolebrai.ogg)!

More information about the project can be found on its
[website](http://dolebrai.net) (still only in french).
As an example of a (now not so) simple liquidsoap configuration,
here is the script used on that radio.

```
#!/home/dbaelde/bin/liquidsoap -v

set("root.max_latency",30.)
set("server.telnet",true)
set("server.socket.permissions",0o660)
set("tag.encodings",["UTF-8","ISO-8859-1"])

%include "dolutils.liq"

root     = "/var/cache/dolebrai/"
scripts  = "/home/dbaelde/scripts/"
last_xml = "/home/dbaelde/dolebrai_public_html/last.xml"
default  = "/var/cache/dolebrai/local/gelnior/jazz/07-patamouchto.mp3"

add_protocol("dolebrai",
  fun (arg,delay) ->
    get_process_lines("#{scripts}dolebrai-filename #{quote(arg)}"))

# === MAIN SOURCE ===

# play explicit requests (from admins) or the playlist

default = single(id="default",default)

s =
  request.dynamic(id="scheduler",default_duration=30.,length=1.,
    fun () ->
      request(get_process_output("#{scripts}/scheduler.pl 2>> #{scripts}/log")))

s = fallback([ request.queue(id="q"), s, default ])

# Feedback is provided for any file played, be it from scheduler.pl, user 
# request via the queue or the default file.
# By the way we refresh the XML describing the latest tracks.
def feedback(m)
  system("#{scripts}/feedback.pl #{quote(m['filename'])} 2>> #{scripts}/logf")
  system("#{scripts}/last.rb > #{last_xml}")
end
# Add a telnet control to get info before metadata rewriting, used by last.rb
s = store_metadata(size=20,id="history",s)
s = on_metadata(feedback,s)

# Prepend introductory tracks if necessary
intro_mix = single("/var/cache/dolebrai/local/jingles/in_vitro/DJLEmb2.mp3")
def choose_prepend(m)
  if m["prepend_track"] != "" then
    request.queue(interactive=false,queue=[request(m["prepend_track"])])
  elsif m["track_type"] == "mix" then
    # This is more reliable than prepend_track as intro_mix is always ready
    intro_mix
  else
    fallback([])
  end
end
s = prepend(s, choose_prepend)

# === TWEAKS (blanks & metadata) ===

# Cut blanks (bonus-tracks)
s = skip_blank(length=7.,s)

# Rewrite metadata
s = rewrite_metadata([("title","$(title) (Dolebrai)"),
                      ("comment","http://dolebrai.net")],s)

# === JINGLES ===

# Metadata rewriting wrapper for jingle sources
def jingle_meta(j)
  rewrite_metadata([("artist", "Dolebrai"),
                    ("title","Jingle (Dolebrai)"),
                    ("comment","http://dolebrai.net")],j)
end

# One source for static jingles, added between tracks
jingles_stat = jingle_meta(playlist.safe(reload=3600,root^"jingles.static"))

# Add cross-fading, inserting "static" jingles during the fade..
def fade(jingles,s)
  fade_in = 2.
  fade_out = 2.
  start_next = 2.
  j = random(id="jrand",
             strict=true,weights=[1,5],
             [jingles, blank(id="bbb",duration=1.)])
  def fader(from,to)
    from = fade.out(duration=fade_out,from)
    to = fade.in(duration=fade_in,to)
    add(normalize=false,
        [ to,
          sequence([ j, fallback([]) ]),
          from ])
  end
  cross(duration=start_next,fader,s)
end
# s = fade(jingles_stat,s)
# Use the fader defined in dolutils.liq
# The smart fade tends to loose some metadata because there is no handling of 
# them in the generators...
s = dole_fade(jingles=jingles_stat,s)

# One for dynamic jingles, mixed on top of the stream with smooth starts/ends.
jingles_dyn = jingle_meta(playlist(reload=3600,root^"jingles.dynamic"))
jingles_dyn = fallback([request.queue(id="dynq"),jingles_dyn])
s = smooth_add(normal=s,special=switch([({ 0m0s or 30m0s }, jingles_dyn)]))

# === ADMIN INTERACTION ===
# More interactivity to come, included live show hooks & co
# s = mix([s,request.equeue(id="eq")])

# === OUTPUT ===
out_mp3 = output.icecast(%mp3, 
    password="XXX", bitrate=64, samplerate=22050, quality=2,
    genre="Musique Libre",
    url="http://dolebrai.net",
    description="La radio des musiques libres")
out_vorbis = output.icecast(%vorbis, 
    password="XXX",
    genre="Musique Libre",
    description="La radio des musiques libres")

# s = normalize(s)
s = audio_process(s)

out_vorbis(port=8000,mount="dolebrai.ogg",s)
out_mp3(port=8000,mount="dolebrai.mp3",s)

# out(port=7144,s) # One for peercast

# Start a watchdog to tell us if liquidsoap crashes
system("#{scripts}watchdog-dolebrai &")
```

Finally our `dolutils.liq` library, included from the main script, 
is as follows.

```
def dole_fade (~start_next=3.,~fade_in=3.,~fade_out=3.,
                     ~width=1.,~conservative=false,~jingles,s)
  mf_high = 20.
  mf_medium = 32.
  mf_margin = 4.
  fade.out = fade.out(duration=fade_out)
  fade.in = fade.in(duration=fade_in)

  j = random(id="jrand",
             strict=true,weights=[1,5],
             [jingles, blank(id="bbb",duration=1.)])
  add = fun (from,to) ->
    add(normalize=false,
        [ to,
          sequence([ j, fallback([]) ]),
          from ])

  log = log(label="dole_fade")

  def transition (a, b, ma, mb, sa, sb)
    if
      (a + mf_high >= 0. and b + mf_high >= 0.) or
      (a + mf_medium >= 0. and b + mf_medium >= 0. and abs(a - b) <= mf_margin)
    then
      log("No transition, just sequencing.")
      sequence([sa, sb])

    elsif
      a + mf_medium <= 0. and b + mf_medium >= 0. and abs(a - b) <= mf_margin
    then
      log("Using transition 1: crossed.")
      add(fade.out(sa),fade.in(sb))

    elsif
      b >= a + mf_margin and a <= mf_high
    then
      log("Using transition 2: crossed, fade-out.")
      add(fade.out(sa),sb)

    elsif
      a >= b + mf_margin and b <= mf_high
    then
      log("Using transition 3: crossed, fade-in.")
      add(sa,fade.in(sb))

    else
      log("Using transition 4: crossed, fade-in, fade-out.")
      add(fade.out(sa),fade.in(sb))
    end
  end

  smart_cross(transition,
               width=width,
               duration=start_next,conservative=conservative,
               s)
end

def audio_process(s)
  gain = interactive.float("compress.gain",3.)
  ratio = 3. # interactive.float("compress.ratio",3.)
  threshold = interactive.float("compress.threshold",-15.)

  target = interactive.float("norm.target",-13.)
  k_up = interactive.float("norm.kup",0.005)
  k_down = interactive.float("norm.kdn",0.1)

  s = normalize(target=target,k_up=k_up,k_down=k_down,s)
  s = compress(gain=gain,ratio=ratio,threshold=threshold,s)
  s
end
```


