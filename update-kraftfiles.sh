#!/bin/sh

for k in $(find -name Kraftfile -type f); do
    ./update-kraftfile.sh "$k"
done
