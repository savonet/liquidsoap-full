#!/bin/sh -e

for image in debian:testing debian:stable ubuntu:eoan ubuntu:focal; do
  docker pull $image;
  ./update-deps.sh $image;
  ./update-full.sh $image;
done;
