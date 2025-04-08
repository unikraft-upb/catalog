#!/bin/sh

curl localhost:3000/login | grep 'rafana'
if test $? -ne 0; then
    echo "Message not found"
    exit 1
fi
