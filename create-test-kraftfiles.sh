#!/bin/sh

for k in $(find library/ native/ examples/ tests/ -name Kraftfile -type f); do
    ./create-test-kraftfile.sh "$k"
done
