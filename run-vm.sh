#!/bin/bash

set -ex

export CI_PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/../"

#source $CI_PROJECT_DIR/scripts/env

KERNEL="./kernel"

TARGET="rd.systemd.unit=rescue.target"

#CDROM="-cdrom archlinux-2021.02.01-x86_64.iso"
#CDROM="-drive index=0,media=cdrom,file=archlinux-2021.02.01-x86_64.iso"
CDROM="-cdrom test.iso"

APPEND_EXTRA=""

APPEND_EXTRA="$APPEND_EXTRA "

virtfs_share=""
#virtfs_share="-virtfs local,path=/tmp/virt-share,mount_tag=host0,security_model=mapped,id=host0"


  #-drive file=$CI_PROJECT_DIR/buildroot-$BUILDROOT_VERSION/output/images/disk.img,index=0,media=disk,if=virtio \
qemu-system-x86_64 -no-reboot -nographic  \
  #-kernel $KERNEL \
  #-initrd initramfs.img.lz4 \
  #-append "console=ttyS0 \
           #$TARGET \
           #rd.shell=1 \
           #$APPEND_EXTRA" \
  $CDROM \
  -cpu host \
  -smp cpus=1 \
  -m 2048 \
  -machine type=pc,accel=kvm \
  -net nic,model=virtio \
  $virtfs_share

