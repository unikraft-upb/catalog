#!/bin/sh

curl localhost:8404/stats | grep 'stat'
if test $? -ne 0; then
    echo "Message not found"
    exit 1
fi
