FROM savonet/liquidsoap-deps

MAINTAINER The Savonet Team <savonet-users@lists.sourceforge.net>

USER opam

WORKDIR /tmp

RUN git clone https://github.com/savonet/liquidsoap-full.git

WORKDIR /tmp/liquidsoap-full

RUN make init && make update

RUN cp PACKAGES.default PACKAGES

RUN ./bootstrap

RUN eval $(opam config env) && ./configure && make clean && make

USER root

RUN make install

# Make sure the image is always up-to date.
ONBUILD USER opam
ONBUILD WORKDIR /tmp/liquidsoap-full
ONBUILD RUN eval $(opam config env) && make update && ./bootstrap && ./configure && make clean && make
