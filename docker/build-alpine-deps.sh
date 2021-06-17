#!/bin/sh -e

export ARCHITECTURE=`dpkg --print-architecture`
TAG=alpine_$ARCHITECTURE
BUILD_IMAGE=savonet/liquidsoap-deps-with-history:${TAG}
EXPORTED_IMAGE=savonet/liquidsoap-deps:${TAG}

docker build --build-arg EXCLUDED_PACKAGES="dssi" -f Dockerfile.alpine-deps . -t ${BUILD_IMAGE}

id=$(docker create ${BUILD_IMAGE})

docker export $id | docker import - ${EXPORTED_IMAGE}

docker rm -v $id

docker push ${EXPORTED_IMAGE}

