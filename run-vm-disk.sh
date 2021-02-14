#!/bin/bash

set -ex

virtfs_share=""
#virtfs_share="-virtfs local,path=/tmp/virt-share,mount_tag=host0,security_model=mapped,id=host0"


  #-netdev user,id=eth0 -device virtio-net-device,netdev=eth0 \
qemu-system-x86_64 -no-reboot -nographic  \
  -drive file=`pwd`/disk.img,index=0,media=disk,if=virtio \
  -cpu host \
  -smp cpus=1 \
  -m 2048 \
  -machine type=pc,accel=kvm \
  -net nic,model=virtio \
  $virtfs_share

