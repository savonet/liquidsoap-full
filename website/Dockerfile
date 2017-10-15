FROM savonet/liquidsoap-full

MAINTAINER The Savonet Team <savonet-users@lists.sourceforge.net>

USER root

COPY .gitconfig /home/opam/.gitconfig
RUN chown -R opam /home/opam/.gitconfig && chmod 600 /home/opam/.gitconfig

COPY .ssh /home/opam/.ssh
RUN chown -R opam /home/opam/.ssh && chmod 600 /home/opam/.ssh/*

USER opam

WORKDIR /tmp/liquidsoap-full

RUN rm -rf website/savonet.github.io

RUN git checkout master && git reset --hard HEAD && git pull

RUN cp PACKAGES.default PACKAGES

RUN make update && cd ocaml-ffmpeg && git checkout 0.1.2

RUN eval $(opam config env) && ./bootstrap && ./configure --enable-graphics && make clean && make

WORKDIR /tmp/liquidsoap-full/website

RUN eval $(opam config env) && make clean && make dist && make actual-upload

