#!/bin/sh

if test $# -ne 1; then
    echo "$0 path/to/kraftfile" 1>&2
    exit 1
fi

src_kraftfile="$1"
test_kraftfile="$src_kraftfile".test

if ! test -f "$src_kraftfile"; then
    echo "$src_kraftfile is no a file." 1>&2
    exit 1
fi

yq < "$src_kraftfile" > /dev/null 2>&1
if test $? -ne 0; then
    echo "$src_kraftfile is a not a YAML file." 1>&2
    exit 1
fi

cp "$src_kraftfile" "$test_kraftfile"

# Update `runtime` line in Kraftfile (if present)
sed -i 's/^runtime: \(.*\)$/runtime: local-\1/g' "$test_kraftfile"

# Update repository configurations (if present) in test Kraftfile.
p="$(pwd)"
d="$p"/"$(dirname "$test_kraftfile")"

replace_name()
{
    name="$1"
    replace="$2"
    padding="$3"
    sed -i '/'"$name"'/{N;N;s|'"$name"':.*\n[ \t]*source:.*\n[ \t]*version:.*$|'"$name:\n${padding}source: $d/repos/$replace"'|g}' "$test_kraftfile"
    sed -i '/'"$name"'/{N;N;s|'"$name"':.*\n[ \t]*version:.*\n[ \t]*source:.*$|'"$name:\n${padding}source: $d/repos/$replace"'|g}' "$test_kraftfile"
    sed -i '/'"$name"'/{N;s|'"$name"':.*\n[ \t]*version:.*$|'"$name:\n${padding}source: $d/repos/$replace"'|g}' "$test_kraftfile"
    sed -i '/'"$name"': \(stable\|staging\|prod\).*/s|'"$name"':.*$|'"$name:\n${padding}source: $d/repos/$replace"'|g' "$test_kraftfile"
}

# Update `unikraft` repository configuration.
replace_name "unikraft" "unikraft" "  "

# Update `elfloader` repository configuration.
replace_name "template" "apps/elfloader" "  "

# Update library repository configuration.
for n in "lwip" "libelf" "musl" "nginx" "compiler-rt" "redis" "ruby" "lua" "libcxx" "libcxxabi" "libunwind" "libgcc" "sqlite" "python3" "libuuid" "zlib"; do
    replace_name "$n" "libs/$n" "    "
done
