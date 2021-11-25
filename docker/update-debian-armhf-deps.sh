#!/bin/sh -e

export BASE_IMAGE=arm32v7/debian:bullseye
export ARCHITECTURE=armhf
export DOCKER_PLATFORM=linux/arm/v7

TAG=`echo ${BASE_IMAGE} | sed -e 's#/#_#g' | sed -e 's#:#_#g'`_$ARCHITECTURE
BUILD_IMAGE=savonet/liquidsoap-deps-with-history:${TAG}
EXPORTED_IMAGE=savonet/liquidsoap-deps:${TAG}

export OS=`echo ${BASE_IMAGE} | cut -d':' -f 1`
export DISTRIBUTION=`echo ${BASE_IMAGE} | cut -d':' -f 2`

docker buildx build --platform ${DOCKER_PLATFORM} --no-cache -t ${EXPORTED_IMAGE} --build-arg EXCLUDED_PACKAGES --build-arg BASE_IMAGE --build-arg OS --build-arg ARCHITECTURE --build-arg DISTRIBUTION -f Dockerfile.debian-armhf-deps .

docker push ${EXPORTED_IMAGE}
