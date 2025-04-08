#!/bin/sh

test -d "repos"
if test ! -e "repos"; then
    echo "No such entry repos. Create one first." 1>&2
    exit 1
fi

for k in $(find -name Kraftfile -type f); do
    d=$(dirname "$k")
    p=$(pwd)
    cd "$d"
    ln -sfn "$p"/repos .
    cd "$p"
done
