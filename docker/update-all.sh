#!/bin/sh -e

for image in debian:testing debian:stable ubuntu:disco ubuntu:eoan; do
  ./update-deps.sh $image;
  ./update-full.sh $image;
done;
