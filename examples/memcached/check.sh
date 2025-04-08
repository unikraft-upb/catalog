#!/bin/sh

echo "set test 0 0 1" | telnet 127.0.0.1 11211 | grep 0
if test $? -ne 0; then
    echo "Message not found"
    exit 1
fi
