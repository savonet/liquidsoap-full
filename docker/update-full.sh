#!/bin/sh -e

docker build -t savonet/liquidsoap-full -f Dockerfile.full .
docker push savonet/liquidsoap-full
