#!/bin/sh -e

export OCAML_VERSION=$1
TAG=alpine
BUILD_IMAGE=savonet/liquidsoap-ci:${TAG}-${OCAML_VERSION}

depot build --push --platform linux/amd64,linux/arm64 --build-arg OCAML_VERSION -f Dockerfile.alpine-ci . -t ${BUILD_IMAGE}
