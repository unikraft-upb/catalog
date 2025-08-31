#!/bin/sh

sleep 20
curl localhost:1313 | grep 'Hugo'
if test $? -ne 0; then
    echo "Message not found"
    exit 1
fi
