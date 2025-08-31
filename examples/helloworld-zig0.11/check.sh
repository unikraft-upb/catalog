#!/bin/sh

grep 'Bye, World!' run.log
if test $? -ne 0; then
    echo "Message not found"
    exit 1
fi
