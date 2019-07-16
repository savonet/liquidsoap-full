#!/bin/sh -e

BASE_IMAGE=$1

if test -z "${BASE_IMAGE}"; then
  BASE_IMAGE=debian:testing
fi

TAG=`echo ${BASE_IMAGE} | sed -e 's#/#_#g' | sed -e 's#:#_#g'`

docker build --no-cache --build-arg TAG="${TAG}" -t savonet/liquidsoap-full:${TAG} -f Dockerfile.full .
docker push savonet/liquidsoap-full:${TAG}
