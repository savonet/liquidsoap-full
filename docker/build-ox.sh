#!/bin/sh -e

export BASE_IMAGE=$1
export OCAML_VERSION=5.2.0+ox

if test -z "${BASE_IMAGE}"; then
  BASE_IMAGE=debian:testing
fi

TAG=`echo ${BASE_IMAGE} | sed -e 's#/#_#g' | sed -e 's#:#_#g'`
BUILD_VERSION=`echo ${OCAML_VERSION} | sed -e 's#+#-#g'`
BUILD_IMAGE=savonet/liquidsoap-ci:${TAG}-${BUILD_VERSION}

export OS=`echo ${BASE_IMAGE} | cut -d':' -f 1`
export DISTRIBUTION=`echo ${BASE_IMAGE} | cut -d':' -f 2`

if [ "${DISTRIBUTION}" = "focal" ]; then
  export EXTRA_PACKAGES="conf-srt.1"
else
  export EXTRA_PACKAGES="conf-srt-gnutls"
fi

if [ "$BASE_IMAGE" = "ubuntu:groovy" ]; then
  export EXCLUDED_PACKAGES=srt
fi

depot build -t ${BUILD_IMAGE} --platform linux/amd64,linux/arm64 --push --build-arg OCAML_VERSION --build-arg EXTRA_PACKAGES --build-arg EXCLUDED_PACKAGES --build-arg BASE_IMAGE --build-arg OS --build-arg ARCHITECTURE --build-arg DISTRIBUTION -f Dockerfile.oxcaml .
