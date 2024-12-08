#!/bin/sh

for k in $(find -name Kraftfile -type f); do
    d=$(dirname "$k")
    ./build-app.sh "$d"
done
