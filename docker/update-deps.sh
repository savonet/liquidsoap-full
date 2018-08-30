#!/bin/sh -e

docker build -t savonet/liquidsoap-deps -f Dockerfile.deps .
docker push savonet/liquidsoap-deps
