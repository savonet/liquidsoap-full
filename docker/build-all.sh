#!/bin/sh -e

screen -dmS alpine /bin/sh -c "./build-alpine-ci.sh"

#if uname -a | grep aarch64 >/dev/null; then
#  screen -dmS debian-armhf -c "./build-armhf-ci.sh debian"
#  screen -dmS alpine-armhf -c "./build-armhf-ci.sh alpine"
#fi

for image in debian:bullseye debian:bookworm ubuntu:jammy ubuntu:focal; do
  screen -dmS $image /bin/sh -c "./build-ci.sh $image"
done;
