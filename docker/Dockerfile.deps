FROM debian:unstable

ENTRYPOINT bash

MAINTAINER The Savonet Team <savonet-users@lists.sourceforge.net>

# Add back graphics when/if ported to 4.08.0
ENV EXT_PACKAGES="camlimages gd inotify sdl-liquidsoap ssl yojson"

USER root

# For libfdk-aac-dev
RUN sed -e 's#main#main contrib non-free#' -i /etc/apt/sources.list

RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends aspcud autoconf automake build-essential ca-certificates curl git pandoc unzip && \
    apt-get -y autoclean && \
    apt-get -y clean

RUN \
    curl -sL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh -o /tmp/install.sh && \
    echo /usr/local/bin | sh /tmp/install.sh

RUN adduser opam

USER opam

WORKDIR /tmp

RUN git clone https://github.com/savonet/liquidsoap-full.git

WORKDIR /tmp/liquidsoap-full

RUN make init && make update

RUN \
    opam init -y --disable-sandboxing --compiler=4.08.0 && \
    opam update -y && \
    opam install -y depext && \
    opam clean

RUN \
    cat PACKAGES.default | grep '^ocaml' | cut -d'-' -f 2 | while read package; do \
      cd ocaml-$package && opam pin add --no-action . && cd ..; \
    done && cd liquidsoap && opam pin add --no-action .

RUN opam depext -y -l liquidsoap $EXT_PACKAGES `cat PACKAGES.default | grep '^ocaml' | cut -d'-' -f 2 | xargs echo` > /tmp/deps

USER root

RUN \
    cat /tmp/deps | xargs apt-get install -y --no-install-recommends && \
    apt-get -y autoclean && apt-get -y clean

USER opam

RUN \
    eval $(opam config env) && \
    opam install -y $EXT_PACKAGES && \
    opam clean

RUN \
    eval $(opam config env) && \
    PACKAGES=`cat PACKAGES.default | grep '^ocaml' | cut -d'-' -f 2 | xargs echo` && \
    opam install -y liquidsoap $PACKAGES && opam uninstall liquidsoap $PACKAGES
