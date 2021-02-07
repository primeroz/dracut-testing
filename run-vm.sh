#!/bin/bash

set -ex

export CI_PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/../"

#source $CI_PROJECT_DIR/scripts/env

KERNEL="./kernel"
virtfs_share=""
#virtfs_share="-virtfs local,path=/tmp/virt-share,mount_tag=host0,security_model=mapped,id=host0"


  #-drive file=$CI_PROJECT_DIR/buildroot-$BUILDROOT_VERSION/output/images/disk.img,index=0,media=disk,if=virtio \
qemu-system-x86_64 -no-reboot -nographic \
  -kernel $KERNEL \
  -initrd initramfs.img.lz4 \
  -append "console=ttyS0 \
            rd.systemd.unit=emergency.target \
            rd.shell=1 " \
  -cpu host \
  -smp cpus=1 \
  -m 2048 \
  -machine type=pc,accel=kvm \
  -net nic,model=virtio \
  $virtfs_share

