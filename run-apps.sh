#!/bin/sh

for k in $(find library/ -name Kraftfile -type f); do
    d=$(dirname "$k")
    ./run-app.sh "$d"
done

for k in $(find examples/ -name Kraftfile -type f); do
    d=$(dirname "$k")
    # Do not run net-tools.
    echo "$d" | grep "net-tools" > /dev/null
    if test $? -eq 0; then
        continue
    fi
    ./run-app.sh "$d"
done

for k in $(find native/ -name Kraftfile -type f); do
    d=$(dirname "$k")
    # Do not run Rust. It requires another build type.
    echo "$d" | grep "-rs\$" > /dev/null
    if test $? -eq 0; then
        continue
    fi
    ./run-app.sh "$d"
done
