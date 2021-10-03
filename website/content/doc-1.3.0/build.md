Building liquidsoap from source
===============================
From every sub-project's directory (ocaml-vorbis, ocaml-dtools, liquidsoap, 
etc.) you can build using `./bootstrap`, `./configure`, 
`make` and optionally install using `make install`.

If you are using the `liquidsoap-full` tarball,
or the latest source code from our
[github repository](https://github.com/savonet/liquidsoap-full),
there is also a fast procedure for building liquidsoap
that doesn't require installing the libraries provided by Savonet.
The steps to follow are simple.

If you are using the git sources, you need to initialize all submodules
by invoking `make init`, `make update` and finally `./bootstrap`.

You should now choose which features you want to enable when building liquidsoap.
Each shipped feature can be enabled/disabled by editing the
`PACKAGE` file.
Depending on your version you might have to first copy 
`PACKAGES.default` to `PACKAGES`.

Then run the usual commands:

```
# Configure all libraries and packages.
# You may pass extra options such as --enable-debugging,
# --prefix, --sysconfdir, --localstatedir, etc.
./configure

# Now, build all libraries and liquidsoap
make

# To install liquidsoap,
# you usually need to type the following as root
make install
```

Dependencies
------------
Here are liquidsoap's dependencies.
All OCaml libraries are distributed by Savonet, except when linked.
You may refer to the liquidsoap INSTALL file for required versions of the 
libraries:

* [ocamlfind](http://www.ocaml-programming.de/programming/findlib.html)
* ocaml-dtools (>= 0.3.0)
* ocaml-duppy (>= 0.4.2)
* ocaml-mm (>= 0.2.1)
* [ocaml-pcre](https://github.com/mmottl/pcre-ocaml)

And also optional dependencies. For most of these, you also need
the associated C/C++ library, which is usually provided by your distribution's
packaging system. You may as well need additional dependencies, such as `g++`, used
for building bindings built on top of C++ libraries, as marked below and possibly
also `libtool`.

* ocaml-ogg for ogg audio and video formats
* ocaml-vorbis for ogg/vorbis audio encoding and decoding
* ocaml-cry for Icecast/Shoutcast streaming
* ocaml-mad for mp3 decoding
* ocaml-lame for mp3 encoding
* ocaml-shine for fixed-point mp3 encoding
* ocaml-faac for AAC encoding
* ocaml-fdkaac for AAC(+) encoding. Replacement candidate for both voaac and aacplus
* ocaml-flac for native flac and ogg/flac encoding/decoding
* ocaml-theora for ogg/theora encoding/decoding
* ocaml-gavl for video conversion
* ocaml-samplerate for audio samplerate conversion
* ocaml-taglib for MP3 audio tag reading (needs `g++`)
* ocaml-magic for file type detection. This library is very useful for reading mp3 files. If not enabled, liquidsoap may accept as mp3 files that do not contains mp3 data, such as jpeg pictures.
* ocaml-xmlplaylist for XML-based playlist formats
* ocaml-soundtouch for soundtouch audio effects (need `g++`)
* ocaml-lastfm and ocaml-xmllight for lastfm protocol support
* [camomile](http://camomile.sourceforge.net/) for detecting metadata encoding and re-encoding them to utf8
* ocaml-alsa for ALSA input/output
* ocaml-ao for AO I/O
* ocaml-portaudio for Portaudio I/O
* ocaml-bjack for Jack output/input
* ocaml-ladspa for LADSPA plugins
* [xmlm](http://erratique.ch/software/xmlm)
* [camlimages](http://pauillac.inria.fr/camlimages/) for image decoding
* [ocaml-sdl](http://ocamlsdl.sourceforge.net/home.html) for display, font & image support
* [ocaml-inotify](http://projects.snarc.org/ocaml-inotify) to monitor file changes, in particular with playlists.

Runtime dependencies include:

* [curl](https://curl.haxx.se/) for downloading remote files (http, https, ftp)
* [festival](http://www.cstr.ed.ac.uk/projects/festival/) for speech synthesis (say)

And other that you'll find on the project page, or in liquidsoap-full tarball.


