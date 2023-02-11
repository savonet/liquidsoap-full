#!/bin/sh -e

export BASE_IMAGE=$1
IS_ARMHF_BUILD=$2

if test -z "${BASE_IMAGE}"; then
  BASE_IMAGE=debian:testing
fi

if [ -n "${IS_ARMHF_BUILD}" ]; then
  ARCHITECTURE=armhf
  DOCKER_PLATFORM="--platform linux/arm/v7"
  BUILDX=buildx
else
  ARCHITECTURE=`dpkg --print-architecture`
  DOCKER_PLATFORM=
  BUILDX=
fi

TAG=`echo ${BASE_IMAGE} | sed -e 's#/#_#g' | sed -e 's#:#_#g'`_$ARCHITECTURE
BUILD_IMAGE=savonet/liquidsoap-ci-with-history:${TAG}
EXPORTED_IMAGE=savonet/liquidsoap-ci:${TAG}

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

docker ${BUILDX} build -t ${BUILD_IMAGE} ${DOCKER_PLATFORM} --build-arg EXTRA_PACKAGES --build-arg EXCLUDED_PACKAGES --build-arg BASE_IMAGE --build-arg OS --build-arg ARCHITECTURE --build-arg DISTRIBUTION -f Dockerfile.ci .

id=$(docker create ${BUILD_IMAGE})

docker export $id | docker import - ${EXPORTED_IMAGE}

docker rm -v $id

docker push ${EXPORTED_IMAGE}

docker push savonet/liquidsoap-ci:${TAG}
