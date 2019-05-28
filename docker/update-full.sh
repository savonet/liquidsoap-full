#!/bin/sh -e

BUILD_IMAGE=savonet/liquidsoap-full-with-history
EXPORTED_IMAGE=savonet/liquidsoap-full

docker build --no-cache -t ${BUILD_IMAGE} -f Dockerfile.full .

id=$(docker create ${BUILD_IMAGE})

docker export $id | docker import - ${EXPORTED_IMAGE}

docker rm -v $id

docker push ${EXPORTED_IMAGE}
