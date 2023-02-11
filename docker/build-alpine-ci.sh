#!/bin/sh -e

IS_ARMHF_BUILD=$1

if [ -n "${IS_ARMHF_BUILD}" ]; then
  ARCHITECTURE=armhf
  DOCKER_PLATFORM="--platform linux/arm/v7"
  BUILDX=buildx
else
  ARCHITECTURE=`dpkg --print-architecture`
  DOCKER_PLATFORM=
  BUILDX=
fi

TAG=alpine_$ARCHITECTURE
BUILD_IMAGE=savonet/liquidsoap-ci-with-history:${TAG}
EXPORTED_IMAGE=savonet/liquidsoap-ci:${TAG}

docker ${BUILDX} build ${DOCKER_PLATFORM} -f Dockerfile.alpine-ci . -t ${BUILD_IMAGE}

id=$(docker create ${BUILD_IMAGE})

docker export $id | docker import - ${EXPORTED_IMAGE}

docker rm -v $id

docker push ${EXPORTED_IMAGE}

