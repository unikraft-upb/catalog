#!/bin/sh

curl localhost:8080/?q=awesome_travis | grep 'calendar'
if test $? -ne 0; then
    echo "Message not found"
    exit 1
fi
