FROM ocaml/opam:debian-testing_ocaml-4.02.3

MAINTAINER The Savonet Team <savonet-users@lists.sourceforge.net>

USER root

# For libfdk-aac-dev
RUN sed -e 's#main#main contrib non-free#' -i /etc/apt/sources.list

# For libaacplus-dev
RUN echo "deb http://www.deb-multimedia.org testing main non-free" >> /etc/apt/sources.list

RUN apt-get update

RUN apt-get install -y --force-yes --no-install-recommends autoconf automake curl festival sox git libxml-dom-perl libgd-dev libao-dev portaudio19-dev libasound2-dev libpulse-dev libjack-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libmad0-dev libtag1-dev libmp3lame-dev libshine-dev  libaacplus-dev libogg-dev libvorbis-dev libspeex-dev libtheora-dev libopus-dev libschroedinger-dev libvo-aacenc-dev libfdk-aac-dev libfaad-dev libflac-dev ladspa-sdk libsoundtouch-dev libsamplerate0-dev libgavl-dev libavutil-dev libswscale-dev frei0r-plugins-dev dssi-dev liblo-dev libmagic-dev libsdl1.2-dev libsdl-image1.2-dev libsdl-mixer1.2-dev libsdl-ttf2.0-dev libsdl-gfx1.2-dev libgl1-mesa-dev libglu1-mesa-dev tk8.5-dev

USER opam

RUN opam install pcre camomile inotify magic base-bytes xmlm camlimages ocamlsdl yojson

WORKDIR /tmp

# Install gd module.
RUN curl -L http://sourceforge.net/projects/gd4o/files/gd4o/1.0%20Alpha%205/gd4o-1.0a5.tar.gz -o gd4o-1.0a5.tar.gz && tar xvzf gd4o-1.0a5.tar.gz

WORKDIR /tmp/gd4o-1.0a5

RUN eval $(opam config env) && make CFLAGS=-fPIC all opt install 

