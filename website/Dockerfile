FROM savonet/liquidsoap-ci:debian_testing_amd64

MAINTAINER The Savonet Team <savonet-users@lists.sourceforge.net>

USER root

COPY .gitconfig /home/opam/.gitconfig
RUN chown -R opam /home/opam/.gitconfig && chmod 600 /home/opam/.gitconfig

COPY .ssh /home/opam/.ssh
RUN chown -R opam /home/opam/.ssh && chmod 600 /home/opam/.ssh/*

RUN apt-get update && apt-get -y install openssh-client

USER opam

WORKDIR /tmp/liquidsoap-full

RUN opam install -y js_of_ocaml-ppx js_of_ocaml

RUN rm -rf website/savonet.github.io

RUN git checkout master && git reset --hard HEAD && git pull

RUN eval $(opam config env) && make clean

RUN make update

RUN cp PACKAGES.default PACKAGES

RUN eval $(opam config env) && export PKG_CONFIG_PATH=/usr/share/pkgconfig/pkgconfig && ./bootstrap && ./configure --enable-graphics && make clean && make

RUN eval $(opam config env) && cd liquidsoap && dune build --release src/js

WORKDIR /tmp/liquidsoap-full/website

RUN eval $(opam config env) && opam install -y odoc && make clean  && make dist && make actual-upload

