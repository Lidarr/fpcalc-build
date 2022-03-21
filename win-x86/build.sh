#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
FFMPEG_DIR="${SCRIPT_DIR}/../ffmpeg"
CHROMAPRINT_DIR="${SCRIPT_DIR}/../chromaprint"
OUT_DIR="${SCRIPT_DIR}/output"

mkdir -p $OUT_DIR

docker build -t fpcalc-win-x86 - < ${SCRIPT_DIR}/Dockerfile

cp -v "${SCRIPT_DIR}/../common.sh" "${FFMPEG_DIR}"
cp -v "${SCRIPT_DIR}/compile-ffmpeg.sh" "${FFMPEG_DIR}"

docker run --rm -v "${FFMPEG_DIR}:/ffmpeg/sources" -v "${OUT_DIR}/ffmpeg:/ffmpeg/build" fpcalc-win-x86 /ffmpeg/sources/compile-ffmpeg.sh

rm "${FFMPEG_DIR}/compile-ffmpeg.sh"
rm "${FFMPEG_DIR}/common.sh"

cp -v "${SCRIPT_DIR}/compile-fpcalc.sh" "${CHROMAPRINT_DIR}"
cp -v "${SCRIPT_DIR}/toolchain.cmake" "${CHROMAPRINT_DIR}"

docker run --rm -v "${CHROMAPRINT_DIR}:/chromaprint/sources" -v "${OUT_DIR}/ffmpeg:/ffmpeg/build" -v "${OUT_DIR}/chromaprint:/chromaprint/build" fpcalc-win-x86 /chromaprint/sources/compile-fpcalc.sh

rm "${CHROMAPRINT_DIR}/compile-fpcalc.sh"
rm "${CHROMAPRINT_DIR}/toolchain.cmake"
