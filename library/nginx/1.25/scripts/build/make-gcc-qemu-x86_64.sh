#!/bin/sh

make distclean
UK_DEFCONFIG=$(pwd)/scripts/defconfig/qemu-x86_64 make defconfig
touch Makefile.uk
make prepare
make initrd.cpio
ln -sfn $(pwd)/initrd.cpio workdir/apps/elfloader/
make COMPILER=gcc -j $(nproc)
test $? -eq 0 && ln -fn workdir/build/nginx_qemu-x86_64 scripts/kernel/gcc-nginx_qemu-x86_64
