#!/bin/sh

for k in $(find library/ -name Kraftfile -type f); do
    d=$(dirname "$k")
    ./pack-app.sh "$d"
done
