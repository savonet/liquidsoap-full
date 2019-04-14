ARG IMAGE
FROM $IMAGE

ARG RELEASE=dev
ARG BRANCH=master
ARG BUILD
ARG HOST

WORKDIR /tmp

USER opam

RUN git clone --recursive https://github.com/savonet/liquidsoap.git && \
    cd liquidsoap && git checkout $RELEASE && ./bootstrap

RUN eval `opam config env` && cd /tmp/liquidsoap && \
  ./configure --enable-custom-path --host=$HOST OCAMLFIND_TOOLCHAIN=windows && \
  env OCAMLFIND_TOOLCHAIN=windows make

RUN mkdir /tmp/win32

COPY --chown=opam:root win32 /tmp/win32

RUN eval `opam config env` && mv /tmp/win32 /tmp/liquidsoap-$BUILD && \
  cd /tmp/liquidsoap-$BUILD && cp /tmp/liquidsoap/src/liquidsoap.exe . && cp /tmp/liquidsoap/scripts/*.liq libs && \
  cp -rf `ocamlfind -toolchain windows ocamlc -where`/../../share/camomile . && \
  cd .. && zip -r liquidsoap-$BUILD.zip liquidsoap-$BUILD 
