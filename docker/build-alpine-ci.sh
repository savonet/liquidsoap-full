#!/bin/sh -e

TAG=alpine
BUILD_IMAGE=savonet/liquidsoap-ci:${TAG}

depot build --push --platform linux/amd64,linux/arm64 -f Dockerfile.alpine-ci . -t ${BUILD_IMAGE}
