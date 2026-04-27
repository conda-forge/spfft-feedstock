#!/bin/bash
set -ex

# Use separate build directories to avoid object file contamination
BUILD_DIR="build_${PKG_NAME}"

if [[ "${PKG_NAME}" == "spfft-static" ]]; then
  BUILD_SHARED="OFF"
  SPFFT_STATIC="ON"
else
  BUILD_SHARED="ON"
  SPFFT_STATIC="OFF"
fi

cmake -B "${BUILD_DIR}" -S . \
  ${CMAKE_ARGS} \
  -GNinja \
  -DBUILD_SHARED_LIBS="${BUILD_SHARED}" \
  -DCMAKE_BUILD_TYPE="Release" \
  -DCMAKE_POSITION_INDEPENDENT_CODE="ON" \
  -DSPFFT_BUILD_TESTS="OFF" \
  -DSPFFT_BUNDLED_LIBS="OFF" \
  -DSPFFT_FORTRAN="ON" \
  -DSPFFT_GPU_BACKEND="OFF" \
  -DSPFFT_GPU_DIRECT="OFF" \
  -DSPFFT_MPI="ON" \
  -DSPFFT_OMP="ON" \
  -DSPFFT_SINGLE_PRECISION="ON" \
  -DSPFFT_STATIC="${SPFFT_STATIC}"
cmake --build "${BUILD_DIR}" --parallel "${CPU_COUNT}"
cmake --install "${BUILD_DIR}"
