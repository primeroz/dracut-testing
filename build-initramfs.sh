#!/bin/bash
set -x

ADDMODULES="biosdevname dmsquash-live rngd"
REMOVEMODULES="bootchart dash mksh busybox dmraid fcoe fcoe-uefi iscsi btrfs crypt multipath lvm network-manager network-wicked nvdimm cifs lunmask nbd nfs nvmf resume"
# network and network-legacy ?
# rootfs-block ?

INSTALL="/usr/bin/lsblk /usr/bin/find"

sudo dracut --add "$ADDMODULES" \
       --omit "$REMOVEMODULES" \
       --no-hostonly \
       --no-hostonly-cmdline \
       --no-hostonly-i18n \
       --install "$INSTALL" \
       --strip \
       --reproducible \
       --compress lz4 \
       --force \
       ./initramfs.img.lz4
