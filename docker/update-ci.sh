#!/bin/sh -e

BASE_IMAGE=$1
ARCHITECTURE=2

if test -z "${BASE_IMAGE}"; then
  BASE_IMAGE=debian:testing
fi

if test -z "${ARCHITECTURE}"; then
  ARCHITECTURE=`dpkg --print-architecture`
fi

if [ "${ARCHITECTURE}" = "armhf" ]; then
  DOCKER_BUILD="buildx build --platform linux/arm/v7"
else
  DOCKER_BUILD=build
fi

TAG=`echo ${BASE_IMAGE} | sed -e 's#/#_#g' | sed -e 's#:#_#g'`_$ARCHITECTURE

docker ${DOCKER_PLATFORM} --no-cache --build-arg TAG="${TAG}" -t savonet/liquidsoap-ci:${TAG} -f Dockerfile.ci .
docker push savonet/liquidsoap-ci:${TAG}
