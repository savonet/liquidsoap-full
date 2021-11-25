#!/bin/sh -e

screen -dmS alpine /bin/sh -c "./build-alpine-deps.sh && ./update-ci.sh alpine"

if uname -a | grep aarch64 >/dev/null; then
  screen -dmS debian-armhf -c "./update-debian-armhf-deps.sh"
  screen -dmS alpine-armhf -c "./build-alpine-armhf-deps.sh"
fi

for image in debian:bullseye debian:testing ubuntu:groovy ubuntu:focal; do
  screen -dmS $image /bin/sh -c "./update-deps.sh $image && ./update-ci.sh $image"
done;
