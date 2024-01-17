#!/bin/sh

kernel="scripts/kernel/nginx_qemu-x86_64"
cmd="/usr/sbin/nginx"

if test $# -eq 1; then
    kernel="$1"
fi

# Clean up any previous instances.
sudo pkill -f qemu-system 2> /dev/null
sudo pkill -f firecracker 2> /dev/null
sudo kraft stop --all 2> /dev/null
sudo kraft rm --all 2> /dev/null

# Remove previously created network interfaces.
sudo ip link set dev tap0 down 2> /dev/null
sudo ip link del dev tap0 2> /dev/null
sudo ip link set dev virbr0 down 2> /dev/null
sudo ip link del dev virbr0 2> /dev/null

# Create bridge interface for QEMU networking.
sudo ip link add dev virbr0 type bridge
sudo ip address add 172.44.0.1/24 dev virbr0
sudo ip link set dev virbr0 up

sudo qemu-system-x86_64 \
    -kernel "$kernel" \
    -nographic \
    -m 512M \
    -netdev bridge,id=en0,br=virbr0 -device virtio-net-pci,netdev=en0 \
    -append "netdev.ip=172.44.0.2/24:172.44.0.1 -- $cmd" \
    -cpu max
