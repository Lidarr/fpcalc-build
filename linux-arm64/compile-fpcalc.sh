#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
pushd $SCRIPT_DIR

export FFMPEG_DIR=/ffmpeg/build

CMAKE_ARGS=(
    -DCMAKE_TOOLCHAIN_FILE=/chromaprint/sources/toolchain.cmake
    -DCMAKE_VERBOSE_MAKEFILE=ON
    -DCMAKE_BUILD_TYPE=Release
    -DBUILD_TOOLS=ON
    -DBUILD_TESTS=OFF
    -DBUILD_SHARED_LIBS=OFF
    -DCMAKE_INSTALL_PREFIX=/chromaprint/build
    -DCMAKE_C_FLAGS='-static -static-libgcc -static-libstdc++'
    -DCMAKE_CXX_FLAGS='-static -static-libgcc -static-libstdc++'
)

cmake "${CMAKE_ARGS[@]}"

make -j6
make install/strip

popd
