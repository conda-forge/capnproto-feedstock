#!/bin/bash

set -x

cd c++
autoreconf -vfi
./configure \
    --enable-shared \
    --prefix=$PREFIX

make -j${CPU_COUNT}
make install

# mkdir build
# cd build

# declare -a CMAKE_PLATFORM_FLAGS
# if [[ ${HOST} =~ .*darwin.* ]]; then
#     CMAKE_PLATFORM_FLAGS+=(-DCMAKE_OSX_SYSROOT="${CONDA_BUILD_SYSROOT}")
# fi

# if [ "$(uname)" != "Darwin" ]; then
#     EXTRA_CMAKE_ARGS="$EXTRA_CMAKE_ARGS -DCMAKE_CXX_FLAGS=\"-lrt\""
# fi

# cmake \
#     -DCMAKE_BUILD_TYPE=Release \
#     -DCMAKE_POSITION_INDEPENDENT_CODE=1 \
#     -DCMAKE_INSTALL_PREFIX="$PREFIX" \
#     -DCMAKE_INSTALL_LIBDIR="lib" \
#     -DBUILD_SHARED=ON \
#     $EXTRA_CMAKE_ARGS \
#     ..

# cmake --build . --parallel ${CPU_COUNT}

# cmake --build . --target check

# cmake --build . --target install
