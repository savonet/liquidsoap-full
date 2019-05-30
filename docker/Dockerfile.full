FROM savonet/liquidsoap-deps

ENTRYPOINT bash

MAINTAINER The Savonet Team <savonet-users@lists.sourceforge.net>

USER opam

WORKDIR /tmp/liquidsoap-full

RUN make update

RUN cp PACKAGES.default PACKAGES

RUN ./bootstrap

RUN eval $(opam config env) && ./configure && make clean && make && make doc

USER root

RUN eval $(opam config env) && make install
