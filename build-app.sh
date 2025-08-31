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

# Clean up potential .unikraft/ directory in elfloader.
rm -fr repos/apps/elfloader/.unikraft/
cd "$appdir"
echo -n "build.$appdir ... "
rm -fr .config* .unikraft; kraft build --kraftfile Kraftfile.test --log-level debug --log-type basic --no-cache --no-update --plat qemu --arch x86_64 . > build.log 2>&1
if test $? -eq 0; then
    echo "PASSED"
else
    echo "FAILED"
fi
