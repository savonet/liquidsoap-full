#!/bin/sh -e

export BASE_IMAGE=$1

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
BUILD_IMAGE=savonet/liquidsoap-deps-with-history:${TAG}
EXPORTED_IMAGE=savonet/liquidsoap-deps:${TAG}

export OS=`echo ${BASE_IMAGE} | cut -d':' -f 1`
export DISTRIBUTION=`echo ${BASE_IMAGE} | cut -d':' -f 2`

if [ "$BASE_IMAGE" = "ubuntu:groovy" ]; then
  export EXCLUDED_PACKAGES=srt
fi

docker build -t ${BUILD_IMAGE} ${DOCKER_PLATFORM} --build-arg EXCLUDED_PACKAGES --build-arg BASE_IMAGE --build-arg OS --build-arg ARCHITECTURE --build-arg DISTRIBUTION -f Dockerfile.deps .

id=$(docker create ${BUILD_IMAGE})

docker export $id | docker import - ${EXPORTED_IMAGE}

docker rm -v $id

docker push ${EXPORTED_IMAGE}
