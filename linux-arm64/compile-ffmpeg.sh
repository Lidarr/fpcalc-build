#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
pushd $SCRIPT_DIR

source common.sh

FFMPEG_CONFIGURE_FLAGS+=(
    --prefix=/ffmpeg/build
    --enable-cross-compile
    --cross-prefix=aarch64-linux-gnu-
    --target-os=linux
    --arch=aarch64
)

./configure "${FFMPEG_CONFIGURE_FLAGS[@]}"

make -j6
make install

popd
