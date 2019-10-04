#!/bin/sh -e

export BASE_IMAGE=$1

if test -z "${BASE_IMAGE}"; then
  BASE_IMAGE=debian:testing
fi

TAG=`echo ${BASE_IMAGE} | sed -e 's#/#_#g' | sed -e 's#:#_#g'`
BUILD_IMAGE=savonet/gstreamer:${TAG}

export OS=`echo ${BASE_IMAGE} | cut -d':' -f 1`
export DISTRIBUTION=`echo ${BASE_IMAGE} | cut -d':' -f 2`

docker build -t ${BUILD_IMAGE} --build-arg BASE_IMAGE --build-arg OS --build-arg DISTRIBUTION .

id=$(docker create ${BUILD_IMAGE})

docker cp $id:/tmp/debian/pkgs .

docker rm -v $id
