#!/bin/sh

echo "show databases" | mysql -u root -h 127.0.0.1 -punikraft | grep mysql
if test $? -ne 0; then
    echo "Message not found"
    exit 1
fi
