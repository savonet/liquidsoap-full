#!/bin/sh -e

for ocaml in 4.14.2; do
  screen -dmS alpine-$ocaml /bin/sh -c "./build-alpine-ci.sh $ocaml"

  for image in debian:forky debian:trixie ubuntu:noble ubuntu:plucky; do
    screen -dmS $image-$ocaml /bin/sh -c "./build-ci.sh $image $ocaml"
    screen -dmS $image-5.2.0+ox /bin/sh -c "./build-ox.sh $image 5.2.0+ox"
  done;
done;
