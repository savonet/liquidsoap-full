#!/bin/sh -e

OS=$1

if [ "${OS}" = "debian" ]; then
  IMAGE=savonet/liquidsoap-deps:debian_bookworm_armhf
else
  IMAGE=savonet/liquidsoap-deps:alpine_armhf
fi

docker buildx build --platform=linux/arm/v7 -f Dockerfile.${OS}-armhf-deps -t ${IMAGE} .

docker push ${IMAGE}
