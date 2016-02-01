FROM savonet/liquidsoap-full

MAINTAINER The Savonet Team <savonet-users@lists.sourceforge.net>

USER opam

COPY .gitconfig /home/opam/.gitconfig
RUN chown -R opam /home/opam/.gitconfig && chmod 600 /home/opam/.gitconfig

COPY .ssh /home/opam/.ssh
RUN chown -R opam /home/opam/.ssh && chmod 600 /home/opam/.ssh/*

USER opam

WORKDIR /tmp/liquidsoap-full/website

RUN rm -rf savonet.github.io

RUN eval $(opam config env) && make clean && make dist && make actual-upload

