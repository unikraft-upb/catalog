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
echo -n "run.$appdir ... "

. ./run.config
test -z "$ports"
if test $? -eq 0; then
    kraft run --log-level debug --log-type basic --kraftfile Kraftfile.test --rm --plat qemu --arch x86_64 -M "$memory" . > run.log 2>&1 &
else
    kraft run --log-level debug --log-type basic --kraftfile Kraftfile.test --rm --plat qemu --arch x86_64 -M "$memory" -p "$ports" . > run.log 2>&1 &
fi
sleep 45

./check.sh > check.log 2>&1
if test $? -eq 0; then
    echo "PASSED"
else
    echo "FAILED"
fi

kraft rm --all > /dev/null 2>&1
