#!/bin/sh

IMAGE=savonet/liquidsoap-win32
VERSION=$1

docker build -f Dockerfile.win32-deps -t savonet/liquidsoap-win32-deps . 
docker build --no-cache -f Dockerfile.win32 -t ${IMAGE} --build-arg LIQUIDSOAP_VERSION=$VERSION .
id=$(docker create ${IMAGE})
docker cp $id:/tmp/liquidsoap-$VERSION.zip .
docker rm -v $id
