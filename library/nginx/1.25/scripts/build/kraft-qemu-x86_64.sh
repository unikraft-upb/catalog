#!/bin/sh

rm -fr .unikraft
rm -f .config.*
/home/razvand/unikraft/kraftkit/dist/kraft build --log-level debug --log-type basic --no-cache --no-update --plat qemu --arch x86_64
test $? -eq 0 && ln -fn .unikraft/build/nginx_qemu-x86_64 scripts/kernel/kraft-nginx_qemu-x86_64
