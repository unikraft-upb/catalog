#!/bin/sh

curl localhost:3000 | grep 'Bye, World!'
if test $? -ne 0; then
    echo "Message not found"
    exit 1
fi
