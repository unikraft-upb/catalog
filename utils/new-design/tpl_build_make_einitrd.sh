#!/bin/sh

init_rootfs="{rootfs}"

# Use "rootfs" as the actual rootfs directory.
rootfs="{target_dir}/rootfs"
rm -fr "$rootfs"
mkdir "$rootfs"

# If rootfs is Dockerfile, create directory from Dockerfile.
if test "$(basename "$init_rootfs")" = "Dockerfile"; then
    image_name="uk-{name}"
    d=$(pwd)
    cd {init_dir}
    docker build -o "$rootfs" -f "$init_rootfs" -t "$image_name" .
    cd "$d"
else
    cp -r "$init_rootfs"/* "$rootfs"
fi

# Create CPIO archive to be used as the embedded initrd.
{base}/unikraft/support/scripts/mkcpio {target_dir}/initrd.cpio "$rootfs"

test -d {target_dir}/.unikraft/build || mkdir -p {target_dir}/.unikraft/build
make -f {target_dir}/Makefile distclean
UK_DEFCONFIG={target_dir}/defconfig make -f {target_dir}/Makefile defconfig
touch Makefile.uk
make -f {target_dir}/Makefile prepare
make CC={compiler} -f {target_dir}/Makefile -j $(nproc)
