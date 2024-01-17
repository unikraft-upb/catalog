#!/bin/sh

test -d workdir/unikraft || git clone https://github.com/unikraft/unikraft workdir/unikraft

for l in lwip libelf; do
    test -d workdir/libs/"$l" || git clone https://github.com/unikraft/lib-"$l" workdir/libs/"$l"
done

test -d workdir/apps/ || git clone https://github.com/unikraft/app-elfloader workdir/apps/elfloader
