#!/bin/sh -e

export ARCHITECTURE=`dpkg --print-architecture`
TAG=alpine_$ARCHITECTURE
BUILD_IMAGE=savonet/liquidsoap-ci-with-history:${TAG}
EXPORTED_IMAGE=savonet/liquidsoap-ci:${TAG}

docker build -f Dockerfile.alpine-ci . -t ${BUILD_IMAGE}

id=$(docker create ${BUILD_IMAGE})

docker export $id | docker import - ${EXPORTED_IMAGE}

docker rm -v $id

docker push ${EXPORTED_IMAGE}

