#!/bin/sh

for k in $(find -name Kraftfile -type f); do
    d=$(dirname "$k")
    p=$(pwd)
    cd "$d"
    ln -sfn "$p"/repos .
    cd "$p"
done
