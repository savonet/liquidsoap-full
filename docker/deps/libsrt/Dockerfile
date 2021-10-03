ARG BASE_IMAGE
FROM $BASE_IMAGE

ENTRYPOINT bash

MAINTAINER The Savonet Team <savonet-users@lists.sourceforge.net>

ARG OS
ARG DISTRIBUTION
ARG SRT_VERSION

ENV DEBFULLNAME="The Savonet Team"
ENV DEBEMAIL="savonet-users@lists.sourceforge.net"
ENV DEBIAN_FRONTEND=noninteractive

RUN \
    cat /etc/apt/sources.list | grep '^deb' | sed -e 's#deb #deb-src #g' >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y devscripts debhelper cmake chrpath help2man libssl-dev pkg-config python3-sphinx tclsh git wget && \
    apt-get -y autoclean && \
    apt-get -y clean

RUN \
    git clone https://salsa.debian.org/debian/libsrt.git && \
    wget https://github.com/Haivision/srt/archive/v${SRT_VERSION}.tar.gz -O libsrt-${SRT_VERSION}.orig.tar.gz && \
    tar xvf libsrt-${SRT_VERSION}.orig.tar.gz && \
    cd srt-${SRT_VERSION} && \
    cp -rf ../libsrt/debian . && \
    dch -b -v ${SRT_VERSION}-1~$DISTRIBUTION --distribution $DISTRIBUTION "New Upstream Release" && \
    grep -r srt-multiplex debian | cut -d':' -f 1 | sort -u | while read i; do sed -e 's#srt-multiplex#srt-tunnel#g' -i "$i"; done && \
    fakeroot debian/rules binary && \
    mkdir -p /tmp/debian/pkgs/${OS}_${DISTRIBUTION} && \
    cp ../*.deb /tmp/debian/pkgs/${OS}_${DISTRIBUTION} 
