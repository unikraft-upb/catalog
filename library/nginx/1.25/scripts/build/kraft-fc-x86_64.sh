#!/bin/sh

rm -fr .unikraft
rm -f .config.*
kraft build --log-level debug --log-type basic --no-cache --no-update --plat fc --arch x86_64
test $? -eq 0 && ln -fn .unikraft/build/nginx_fc-x86_64 scripts/kernel/kraft-nginx_fc-x86_64
