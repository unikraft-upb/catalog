#!/bin/sh

echo "stats" | timeout -k 3 3 nc localhost 11211 | grep -i stat
if test $? -ne 0; then
    echo "Message not found"
    exit 1
fi
