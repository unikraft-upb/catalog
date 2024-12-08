#!/bin/sh

if test $# -ne 1; then
    echo "$0 path/to/app" 1>&2
    exit 1
fi

appdir="$1"

if ! test -d "$appdir"; then
    echo "$appdir is no a directory." 1>&2
    exit 1
fi

cd "$appdir"
rm -fr .config* .unikraft; kraft build --log-level debug --log-type basic --no-cache --no-update --plat qemu --arch x86_64 . > build.log 2>&1
if test $? -eq 0; then
    echo "build.$app ... PASSED"
else
    echo "build.$app ... FAILED"
fi
