#!/bin/sh

for k in $(find library/ native/ examples/ tests/ -name Kraftfile -type f); do
    ./update-kraftfile.sh "$k"
done
