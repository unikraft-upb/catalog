#!/bin/sh

curl localhost:9090 | grep 'Hello, World!'
if test $? -ne 0; then
    echo "Message not found"
    exit 1
fi
