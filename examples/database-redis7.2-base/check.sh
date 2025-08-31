#!/bin/sh

echo "set a 1" | redis-cli | grep "OK"
if test $? -ne 0; then
    echo "Message not found"
    exit 1
fi
