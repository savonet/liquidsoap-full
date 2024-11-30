#!/bin/sh

SYSTEM="x64"
OCAML_VERSION=4.14.1
BASE_IMAGE="ocamlcross/windows-${SYSTEM}-base:${OCAML_VERSION}"
IMAGE="savonet/liquidsoap-win32-${SYSTEM}"
HOST="x86_64-w64-mingw32.static"

depot build \
  -f Dockerfile.win32 \
  -t ${IMAGE} \
  --platform linux/amd64 \
  --build-arg RELEASE=${RELEASE} \
  --build-arg IMAGE=${BASE_IMAGE} \
  --build-arg HOST=${HOST} \
  --build-arg BUILD=${BUILD} \
  .
