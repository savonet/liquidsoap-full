#!/bin/sh -e

screen -dmS alpine /bin/sh -c "./build-alpine-deps.sh && ./build-ci.sh alpine"

if uname -a | grep aarch64 >/dev/null; then
  screen -dmS debian-armhf -c "./build-armhf-deps.sh debian && ./build-ci.sh debian:bookworm armhf"
  screen -dmS alpine-armhf -c "./build-armhf-deps.sh alpine && ./build-ci.sh alpine armhf"
fi

for image in debian:bullseye debian:bookworm ubuntu:jammy ubuntu:focal; do
  screen -dmS $image /bin/sh -c "./build-ci.sh $image"
done;
