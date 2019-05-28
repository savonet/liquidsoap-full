#!/bin/sh -e

BUILD_IMAGE=savonet/liquidsoap-deps-with-history
EXPORTED_IMAGE=savonet/liquidsoap-deps

docker build -t ${BUILD_IMAGE} -f Dockerfile.deps .

id=$(docker create ${BUILD_IMAGE})

docker export $id | docker import - ${EXPORTED_IMAGE}

docker rm -v $id

docker push ${EXPORTED_IMAGE}
