#!/bin/sh -e

BASE_IMAGE=$1
ARCHITECTURE=`dpkg --print-architecture`

if test -z "${BASE_IMAGE}"; then
  BASE_IMAGE=debian:testing
fi

TAG=`echo ${BASE_IMAGE} | sed -e 's#/#_#g' | sed -e 's#:#_#g'`_$ARCHITECTURE

docker build --no-cache --build-arg TAG="${TAG}" -t savonet/liquidsoap-ci:${TAG} -f Dockerfile.ci .
docker push savonet/liquidsoap-ci:${TAG}
