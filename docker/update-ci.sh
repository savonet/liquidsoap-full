#!/bin/sh -e

BASE_IMAGE=$1
ARCHITECTURE=$2

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

BUILD_IMAGE=savonet/liquidsoap-ci-with-history:${TAG}
EXPORTED_IMAGE=savonet/liquidsoap-ci:${TAG}

docker ${DOCKER_BUILD} --no-cache --build-arg TAG="${TAG}" -t ${BUILD_IMAGE} -f Dockerfile.ci .

id=$(docker create ${BUILD_IMAGE})

docker export $id | docker import - ${EXPORTED_IMAGE}

docker rm -v $id

docker push ${EXPORTED_IMAGE}

docker push savonet/liquidsoap-ci:${TAG}
