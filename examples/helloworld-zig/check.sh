#!/bin/sh

grep 'Hello, world!' run.log
if test $? -ne 0; then
    echo "Message not found"
    exit 1
fi
