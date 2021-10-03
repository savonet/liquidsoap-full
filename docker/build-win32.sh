#!/bin/sh

BUILD=$1
RELEASE=$2
SYSTEM=$3
OCAML_VERSION=$4

if [ -z "${RELEASE}" ]; then
  RELEASE="master"
fi

if [ -z "${SYSTEM}" ]; then
  SYSTEM="x64"
fi

if [ -z "${OCAML_VERSION}" ]; then
  OCAML_VERSION=4.11.1
fi

BASE_IMAGE="ocamlcross/windows-${SYSTEM}-base:${OCAML_VERSION}"
DEPS_IMAGE="savonet/liquidsoap-win32-deps-${SYSTEM}"
IMAGE="savonet/liquidsoap-win32-${SYSTEM}"

if [ "${SYSTEM}" = "x64" ]; then
  HOST="x86_64-w64-mingw32.static"
else
  HOST="i686-w64-mingw32.static"
fi

docker build -f Dockerfile.win32-deps -t ${DEPS_IMAGE} \
  --build-arg IMAGE=${BASE_IMAGE} .
docker build -f Dockerfile.win32 -t ${IMAGE} --no-cache --build-arg RELEASE=${RELEASE} \
  --build-arg IMAGE=${DEPS_IMAGE} --build-arg HOST=${HOST} --build-arg BUILD=${BUILD} .
id=$(docker create ${IMAGE})
docker cp ${id}:/tmp/liquidsoap-${BUILD}.zip .
docker rm -v ${id}
