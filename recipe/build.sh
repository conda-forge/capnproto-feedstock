#!/bin/bash

set -x

cd c++
autoreconf -vfi

if [[ $target_platform == "linux-"* ]]; then
    export LIBS="-lrt $LIBS"
fi

./configure \
    --enable-shared \
    --prefix=$PREFIX

make -j${CPU_COUNT}
make install