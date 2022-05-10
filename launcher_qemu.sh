
#!/bin/bash

HOST_OS=archlabs-2022.02.12-x86_64.iso
HOST_NAME=bebe-proyectil.qcow2
LFS_NAME=bebe-proyectil-2.qcow2

if [ ! -e $HOST_OS ]; then
    echo "No OS image found"
    exit 1
fi

if [ ! -e $HOST_NAME ]; then
    qemu-img create -f qcow2 ./$HOST_NAME 30G
    qemu-system-x86_64 \
	-cdrom ./$HOST_OS \
	-enable-kvm \
	-smp 2 \
	-m 2G \
	-machine q35 \
	-cpu host \
	-usb \
	-drive file=./$HOST_NAME \
	-nic user,hostfwd=tcp::2222-:22
    echo done;
fi

if [ "$1" = "go" ]; then
    qemu-system-x86_64 \
	-enable-kvm \
	-smp 2 \
	-m 2G \
	-machine q35 \
	-cpu host \
	-usb \
	-drive file=bebe-proyectil-2.qcow2 \
	-nic user,hostfwd=tcp::2222-:22
    exit 0
fi

qemu-system-x86_64 \
    -enable-kvm \
    -smp 2 \
    -m 2G \
    -machine q35 \
    -cpu host \
    -usb \
    -drive file=bebe-proyectil.qcow2 \
    -drive file=bebe-proyectil-2.qcow2 \
    -nic user,hostfwd=tcp::2222-:22


