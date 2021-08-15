#!/bin/sh -e

export BASE_IMAGE=$1
export ARCHITECTURE=`dpkg --print-architecture`

if test -z "${BASE_IMAGE}"; then
  BASE_IMAGE=debian:testing
fi

TAG=`echo ${BASE_IMAGE} | sed -e 's#/#_#g' | sed -e 's#:#_#g'`_$ARCHITECTURE
BUILD_IMAGE=savonet/liquidsoap-deps-with-history:${TAG}
EXPORTED_IMAGE=savonet/liquidsoap-deps:${TAG}

export OS=`echo ${BASE_IMAGE} | cut -d':' -f 1`
export DISTRIBUTION=`echo ${BASE_IMAGE} | cut -d':' -f 2`

if [ "$BASE_IMAGE" = "ubuntu:groovy" ]; then
  export EXCLUDED_PACKAGES=srt
fi

docker build -t ${BUILD_IMAGE} --build-arg EXCLUDED_PACKAGES --build-arg BASE_IMAGE --build-arg OS --build-arg ARCHITECTURE --build-arg DISTRIBUTION -f Dockerfile.deps .

id=$(docker create ${BUILD_IMAGE})

docker export $id | docker import - ${EXPORTED_IMAGE}

docker rm -v $id

docker push ${EXPORTED_IMAGE}
