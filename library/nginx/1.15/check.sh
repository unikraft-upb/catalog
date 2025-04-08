#!/bin/sh

curl localhost:8080 | grep 'Hello from Unikraft'
if test $? -ne 0; then
    echo "Message not found"
    exit 1
fi
