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
echo -n "pack.$appdir ... "
full_name=${appdir#*/}
app_name=${full_name%/*}
app_version=${full_name#*/}
if test -z "$app_version" -o "$app_version" = ""; then
    app_version="latest"
fi
kraft pkg --name "local-$app_name:$app_version" --plat qemu --arch x86_64 .
if test $? -eq 0; then
    echo "PASSED"
else
    echo "FAILED"
fi
