#!/bin/sh

if test $# -ne 1; then
    echo "$0 path/to/kraftfile" 1>&2
    exit 1
fi

kraftfile="$1"

if ! test -f "$kraftfile"; then
    echo "$kraftfile is no a file." 1>&2
    exit 1
fi

yq < "$kraftfile" > /dev/null 2>&1
if test $? -ne 0; then
    echo "$kraftfile is a not a YAML file." 1>&2
    exit 1
fi

p="$(pwd)"
d="$p"/"$(dirname "$kraftfile")"

replace_name()
{
    name="$1"
    replace="$2"
    padding="$3"
    sed -i '/'"$name"'/{N;N;s|'"$name"':.*\n[ \t]*source:.*\n[ \t]*version:.*$|'"$name:\n${padding}source: $d/repos/$replace"'|g}' "$kraftfile"
    sed -i '/'"$name"'/{N;N;s|'"$name"':.*\n[ \t]*version:.*\n[ \t]*source:.*$|'"$name:\n${padding}source: $d/repos/$replace"'|g}' "$kraftfile"
    sed -i '/'"$name"'/{N;s|'"$name"':.*\n[ \t]*version:.*$|'"$name:\n${padding}source: $d/repos/$replace"'|g}' "$kraftfile"
    sed -i '/'"$name"': \(stable\|staging\|prod\).*/s|'"$name"':.*$|'"$name:\n${padding}source: $d/repos/$replace"'|g' "$kraftfile"
}

replace_name "unikraft" "unikraft" "  "
replace_name "template" "apps/elfloader" "  "
for n in "lwip" "libelf" "musl" "nginx" "compiler-rt" "redis" "ruby" "lua" "libcxx" "libcxxabi" "libunwind" "libgcc" "sqlite" "ruby" "python3" "libuuid" "zlib"; do
    replace_name "$n" "libs/$n" "    "
done
