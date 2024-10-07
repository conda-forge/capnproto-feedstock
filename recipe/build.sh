#!/bin/bash

set -x

cd c++
autoreconf -vfi

if [[ $target_platform == "linux-"* ]]; then
    export LIBS="-lrt $LIBS"
fi

BUILD_ARCH=${CONDA_TOOLCHAIN_BUILD%%-*}
HOST_ARCH=${CONDA_TOOLCHAIN_HOST%%-*}

configure_cmd=(./configure --enable-shared --prefix=$PREFIX)

# cross-compiling needs to use prebuilt capnproto
# https://github.com/capnproto/capnproto/issues/1815#issuecomment-1732327995
if [[ "${BUILD_ARCH}" != "${HOST_ARCH}" ]]; then
    configure_cmd+=("--with-external-capnp")
fi

"${configure_cmd[@]}"

make_cmd=(make -j${CPU_COUNT})
if [[ "${BUILD_ARCH}" == "${HOST_ARCH}" ]]; then
    make_cmd+=(check)
fi

"${make_cmd[@]}"

make install
