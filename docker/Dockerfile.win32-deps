ARG IMAGE
FROM $IMAGE

ENV OPAM_DEPS=ao-windows,camomile-windows,cry-windows,dtools-windows,duppy-windows,faad-windows,fdkaac-windows,ffmpeg-windows,flac-windows,gstreamer-windows,lame-windows,mad-windows,menhir,menhir-windows,mm-windows,ogg-windows,opus-windows,pcre-windows,portaudio-windows,samplerate-windows,sedlex-windows,speex-windows,ssl-windows,taglib-windows,theora-windows,vorbis-windows,winsvc-windows,yojson-windows

RUN eval `opam config env` && opam repository remove windows --all && opam repository add windows git://github.com/ocaml-cross/opam-cross-windows && opam update && opam list --short --recursive --external --vars os-distribution=mxe --required-by=$OPAM_DEPS > /home/opam/mxe-deps

USER root

RUN cd /usr/src/mxe/ && cat /home/opam/mxe-deps | xargs make

USER opam

ENV CC ""

RUN eval `opam config env` && opam reinstall -y `echo $OPAM_DEPS | sed -e 's#,# #g'`
