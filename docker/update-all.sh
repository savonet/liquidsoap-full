#!/bin/sh -e

screen -dmS alpine /bin/sh -c "./build-alpine-deps.sh && ./update-ci.sh alpine"

for image in debian:bullseye debian:testing ubuntu:groovy ubuntu:focal; do
  screen -dmS $image /bin/sh -c "./update-deps.sh $image && ./update-ci.sh $image"
done;
