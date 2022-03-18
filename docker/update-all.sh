#!/bin/sh -e

screen -dmS alpine /bin/sh -c "./build-alpine-deps.sh && ./update-ci.sh alpine"

if uname -a | grep aarch64 >/dev/null; then
  screen -dmS debian-armhf -c "./build-armhf-deps.sh debian && ./update-ci.sh debian:bookworm armhf"
  screen -dmS alpine-armhf -c "./build-armhf-deps.sh alpine && ./update-ci.sh alpine armhf"
fi

for image in debian:bullseye debian:testing ubuntu:impish ubuntu:focal; do
  screen -dmS $image /bin/sh -c "./update-deps.sh $image && ./update-ci.sh $image"
done;
