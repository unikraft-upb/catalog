#!/bin/sh

curl localhost:3000/feed | grep -i blog
if test $? -ne 0; then
    echo "Message not found"
    exit 1
fi
