FROM ocaml/opam

MAINTAINER The Savonet Team <savonet-users@lists.sourceforge.net>

USER root

RUN sed -e 's#main#main contrib non-free#' -i /etc/apt/sources.list

# For libaacplus-dev
RUN echo "deb http://www.deb-multimedia.org stable main non-free" >> /etc/apt/sources.list

RUN apt-get update

RUN apt-get install -y --force-yes --no-install-recommends autoconf automake curl festival sox git libao-dev portaudio19-dev libasound2-dev libpulse-dev libjack-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libmad0-dev libtag1-dev libmp3lame-dev libshine-dev  libaacplus-dev libogg-dev libvorbis-dev libspeex-dev libtheora-dev libopus-dev libschroedinger-dev libvo-aacenc-dev libfdk-aac-dev libfaad-dev libflac-dev ladspa-sdk libsoundtouch-dev libsamplerate0-dev libgavl-dev libavutil-dev libswscale-dev frei0r-plugins-dev dssi-dev liblo-dev libmagic-dev libsdl1.2-dev libsdl-image1.2-dev libsdl-mixer1.2-dev libsdl-ttf2.0-dev libsdl-gfx1.2-dev libgl1-mesa-dev libglu1-mesa-dev tk8.5-dev

USER opam

RUN opam install pcre camomile inotify magic base-bytes xmlm camlimages ocamlsdl yojson

WORKDIR /tmp

RUN git clone https://github.com/savonet/liquidsoap-full.git

WORKDIR /tmp/liquidsoap-full

RUN make init && make update

RUN cp PACKAGES.default PACKAGES

RUN ./bootstrap

RUN eval $(opam config env) && ./configure && make clean && make

USER root

RUN make install
