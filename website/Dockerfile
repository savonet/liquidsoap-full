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

RUN eval $(opam config env) && make update && ./bootstrap && ./configure && make clean && make

USER root

WORKDIR /tmp/liquidsoap-full/liquidsoap

RUN make install

WORKDIR /tmp/liquidsoap-full/website

RUN eval $(opam config env) && make clean && make dist && make actual-upload

