#!/bin/sh -e

BASE_IMAGE=$1

if test -z "${BASE_IMAGE}"; then
  BASE_IMAGE=debian:testing
fi

if [ "${BASE_IMAGE}" = "arm32v7/debian:bullseye" ]; then
  ARCHITECTURE=armhf
  DOCKER_PLATFORM="--platform linux/arm/v7"
else
  ARCHITECTURE=`dpkg --print-architecture`
  DOCKER_PLATFORM=
fi

TAG=`echo ${BASE_IMAGE} | sed -e 's#/#_#g' | sed -e 's#:#_#g'`_$ARCHITECTURE

docker build --no-cache ${DOCKER_PLATFORM} --build-arg TAG="${TAG}" -t savonet/liquidsoap-ci:${TAG} -f Dockerfile.ci .
docker push savonet/liquidsoap-ci:${TAG}
