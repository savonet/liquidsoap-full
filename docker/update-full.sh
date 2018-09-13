#!/bin/sh -e

docker build --no-cache -t savonet/liquidsoap-full -f Dockerfile.full .
docker push savonet/liquidsoap-full
