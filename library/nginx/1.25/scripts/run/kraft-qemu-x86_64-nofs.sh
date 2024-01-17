#!/bin/sh

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

# Create bridge interface for KraftKit networking.
sudo kraft net create -n 172.44.0.1/24 virbr0

#sudo KRAFTKIT_BUILDKIT_HOST=docker-container://buildkitd kraft run \
sudo KRAFTKIT_BUILDKIT_HOST=docker-container://buildkitd /home/razvand/unikraft/kraftkit/dist/kraft run \
    --log-level debug --log-type basic \
    -W \
    --memory 512M \
    --network bridge:virbr0 \
    --arch x86_64 --plat qemu
