#!/bin/sh

for k in $(find library/ native/ -name Kraftfile -type f); do
    d=$(dirname "$k")
    ./build-app.sh "$d"
done
