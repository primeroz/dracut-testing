#!/bin/bash
set -x

THIS_DIR=`pwd`
TARGET_DIR=$THIS_DIR/root/img
GRUB2_IMAGE=$THIS_DIR/grub.img
GRUB2_CFG=$TARGET_DIR/boot/grub/grub.cfg
GRUB2_PREFIX=$TARGET_DIR/boot/grub
GRUB2_TUPLE=i386-pc
GRUB2_TARGET=i386
GRUB2_PLATFORM=pc
GRUB2_MODULES="at_keyboard configfile biosdisk ext2 linux test serial halt minicmd terminal cat acpi"


cp /usr/lib/grub/i386-pc/boot.img .

/usr/bin/grub-mkimage \
		-O $GRUB2_TUPLE \
		-o $GRUB2_IMAGE \
		-p "$GRUB2_PREFIX" \
    $GRUB2_MODULES
#$(if $(GRUB2_BUILTIN_CONFIG),-c $(GRUB2_BUILTIN_CONFIG)) \

# Build the img directory
rm -rf $TARGETDIR
mkdir -p $TARGET_DIR/boot/grub

install -D -m 0644 grub-bios.cfg $GRUB2_CFG
install -D -m 0644 kernel $TARGET_DIR/boot/kernel
install -D -m 0644 initramfs.img.lz4 $TARGET_DIR/boot/initramfs.img.lz4
install -D -m 0644 rootfs.squashfs $TARGET_DIR/rootfs.squashfs