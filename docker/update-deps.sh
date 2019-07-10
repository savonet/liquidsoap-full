#!/bin/sh -e

BASE_IMAGE=$1

if test -z "${BASE_IMAGE}"; then
  BASE_IMAGE=debian:testing
fi

TAG=`echo ${BASE_IMAGE} | sed -e 's#/#_#g' | sed -e 's#:#_#g'`
BUILD_IMAGE=savonet/liquidsoap-deps-with-history:${TAG}
EXPORTED_IMAGE=savonet/liquidsoap-deps:${TAG}


docker build -t ${BUILD_IMAGE} --build-arg BASE_IMAGE="${BASE_IMAGE}" -f Dockerfile.deps .

id=$(docker create ${BUILD_IMAGE})

docker export $id | docker import - ${EXPORTED_IMAGE}

docker rm -v $id

docker push ${EXPORTED_IMAGE}
