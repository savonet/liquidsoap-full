#!/bin/sh -e

export ARCHITECTURE=armhf
export DOCKER_PLATFORM=linux/arm/v7

TAG=alpine_$ARCHITECTURE
IMAGE=savonet/liquidsoap-deps:${TAG}

docker buildx build --platform="${DOCKER_PLATFORM}" -f Dockerfile.alpine-armhf-deps --output=registry=${IMAGE} .


