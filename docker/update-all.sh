#!/bin/sh -e

for image in debian:testing debian:stable ubuntu:eoan ubuntu:focal; do
  ./update-deps.sh $image;
  ./update-full.sh $image;
done;
