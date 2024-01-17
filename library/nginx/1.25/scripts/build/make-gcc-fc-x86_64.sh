#!/bin/sh

make distclean
UK_DEFCONFIG=$(pwd)/scripts/defconfig/fc-x86_64 make defconfig
touch Makefile.uk
make prepare
make initrd.cpio
ln -sfn $(pwd)/initrd.cpio workdir/apps/elfloader/
make COMPILER=gcc -j $(nproc)
test $? -eq 0 && ln -fn workdir/build/nginx_fc-x86_64 scripts/kernel/gcc-nginx_fc-x86_64
