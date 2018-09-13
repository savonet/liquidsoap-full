#!/bin/sh

IMAGE=savonet/liquidsoap-win32
BUILD=$1
RELEASE=$2

docker build -f Dockerfile.win32-deps -t savonet/liquidsoap-win32-deps . 
docker build -f Dockerfile.win32 -t ${IMAGE} --build-arg RELEASE=$RELEASE --build-arg BUILD=$BUILD .
id=$(docker create ${IMAGE})
docker cp $id:/tmp/liquidsoap-$BUILD.zip .
docker rm -v $id
