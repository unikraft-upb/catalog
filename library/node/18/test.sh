#!/bin/sh

sudo pkill -f kraft
sudo pkill -f kraft-qemu

test -d ./scripts/log || mkdir -p ./scripts/log

./scripts/build/kraft-qemu-x86_64.sh > ./scripts/log/build-kraft-qemu-x86_64 2>&1
if test $? -eq 0; then
    printf "build .............................. PASSED\n"
else
    printf "build .............................. FAILED\n"
    exit 1
fi

sleep 5

./scripts/run/kraft-qemu-x86_64-nofs.sh > ./scripts/log/run-kraft-qemu-x86_64-nofs 2>&1 &

sleep 5

kill -0 $! 2> /dev/null
if test $? -eq 0; then
    printf "run ................................ PASSED\n"
else
    printf "run ................................ FAILED\n"
    exit 1
fi

sleep 20

curl --connect-timeout 3 --max-time 5 172.44.0.2:8080 2> /dev/null | grep -i 'Hello, World!' > /dev/null 2>&1
if test $? -eq 0; then
    printf "test ............................... PASSED\n"
else
    printf "test ............................... FAILED\n"
    exit 1
fi
