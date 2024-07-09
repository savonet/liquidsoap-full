#!/bin/sh -e

screen -dmS alpine /bin/sh -c "./build-alpine-ci.sh"

for image in debian:bookworm debian:trixie ubuntu:noble ubuntu:oracular; do
  screen -dmS $image /bin/sh -c "./build-ci.sh $image"
done;
