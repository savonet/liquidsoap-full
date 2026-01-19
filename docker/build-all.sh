#!/bin/sh -e

for ocaml in 4.14.2 5.4.0; do
  screen -dmS alpine-$ocaml /bin/sh -c "./build-alpine-ci.sh $ocaml"

  for image in debian:forky debian:trixie ubuntu:resolute ubuntu:plucky; do
    screen -dmS $image-$ocaml /bin/sh -c "./build-ci.sh $image $ocaml"
  done;
done;
