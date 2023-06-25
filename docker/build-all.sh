#!/bin/sh -e

screen -dmS alpine /bin/sh -c "./build-alpine-ci.sh"

if uname -a | grep aarch64 >/dev/null; then
  screen -dmS debian-armhf -c "./build-ci.sh debian:trixie true"
  screen -dmS alpine-armhf -c "./build-alpine-ci.sh alpine true"
fi

for image in debian:bookworm debian:trixie ubuntu:jammy ubuntu:lunar; do
  screen -dmS $image /bin/sh -c "./build-ci.sh $image"
done;
