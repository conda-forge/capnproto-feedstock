#!/bin/bash

set -x

cd c++
autoreconf -vfi

if [[ $target_platform == "linux-"* ]]; then
    export LIBS="-lrt $LIBS"
fi

BUILD_ARCH=${CONDA_TOOLCHAIN_BUILD%%-*}
HOST_ARCH=${CONDA_TOOLCHAIN_HOST%%-*}

mkdir -p $PREFIX/ssl/certs

configure_cmd=(./configure --enable-shared --prefix=$PREFIX)

# cross-compiling needs to use prebuilt capnp
# https://github.com/capnproto/capnproto/issues/1815#issuecomment-1732327995
# We should install this using meta.yaml, but currently capnproto requires
# openSSL 1.1, which conflicts with some other dependencies, so we have to
# install it here with --no-deps.
# TODO: remove this when capnproto is updated to use openSSL 3.
if [[ "${BUILD_ARCH}" != "${HOST_ARCH}" ]]; then
    mamba install --no-deps --yes capnproto
    configure_cmd+=("--with-external-capnp")
fi

"${configure_cmd[@]}"

make_cmd=(make -j${CPU_COUNT})
if [[ "${BUILD_ARCH}" == "${HOST_ARCH}" ]]; then
    make_cmd+=(check)
fi

"${make_cmd[@]}"

make install
