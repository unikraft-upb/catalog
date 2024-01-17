#!/bin/sh

config="scripts/run/fc-x86_64-nofs.json"

if test $# -eq 1; then
    config="$1"
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

# Create tap interface for Firecracker networking.
sudo ip tuntap add dev tap0 mode tap
sudo ip address add 172.44.0.1/24 dev tap0
sudo ip link set dev tap0 up

# Remove previously created files.
sudo rm -f /tmp/firecracker.log
touch /tmp/firecracker.log
sudo rm -f /tmp/firecracker.socket
sudo firecracker-x86_64 \
        --api-sock /tmp/firecracker.socket \
        --config-file "$config"
