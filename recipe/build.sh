#!/bin/bash

set -x

cd c++
if [[ $target_platform == osx-* ]]; then
    list_config_to_patch=$(find . -name config.guess | sed -E 's/config.guess//')
    for config_folder in $list_config_to_patch; do
        echo "copying config to $config_folder ...\n"
        cp -v $BUILD_PREFIX/share/libtool/build-aux/config.* $config_folder
    done
else
  autoreconf -vfi
fi

if [[ $target_platform == "linux-"* ]]; then
    export LIBS="-lrt $LIBS"
fi

./configure \
    --enable-shared \
    --prefix=$PREFIX

if [[ $target_platform == "linux-s390x"* ]]; then
    make -j${CPU_COUNT} check || true
else
    make -j${CPU_COUNT} check
fi

make install
