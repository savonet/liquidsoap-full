#!/bin/sh -e

for image in debian:testing debian:stable ubuntu:groovy ubuntu:focal; do
  screen -dmS $image /bin/sh -c "./update-deps.sh $image && ./update-ci.sh $image"
done;
