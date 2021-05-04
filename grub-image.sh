#!/bin/bash
set -x

THIS_DIR=`pwd`
TARGET_DIR=$THIS_DIR/root/img
GRUB2_IMAGE=$THIS_DIR/grub.img
#GRUB2_PREFIX='(hd0,msdos1)/boot/grub'
GRUB2_PREFIX='($root)/boot/grub'
GRUB2_CFG=$TARGET_DIR/boot/grub/grub.cfg
GRUB2_EARLY_CFG=$THIS_DIR/grub-early.cfg
GRUB2_TUPLE=i386-pc
GRUB2_TARGET=i386
GRUB2_PLATFORM=pc
# https://github.com/buildroot/buildroot/blob/master/boot/grub2/Config.in
GRUB2_MODULES="at_keyboard configfile biosdisk ext2 linux test serial halt minicmd terminal cat acpi part_gpt part_msdos boot fat squash4 normal biosdisk search_fs_file search_label"

cp /usr/lib/grub/i386-pc/boot.img .

/usr/bin/grub-mkimage \
		-O $GRUB2_TUPLE \
		-o $GRUB2_IMAGE \
		-p "$GRUB2_PREFIX" \
    -c $GRUB2_EARLY_CFG \
    $GRUB2_MODULES
    #-c $GRUB2_EARLY_CFG \
		#-p "$GRUB2_PREFIX" \

# Build the img directory
rm -rf $TARGETDIR
mkdir -p $TARGET_DIR/boot/grub

install -D -m 0644 grub-bios.cfg $GRUB2_CFG
install -D -m 0644 /boot/vmlinuz-linux $TARGET_DIR/boot/vmlinuz
install -D -m 0644 bzImage $TARGET_DIR/boot/bzImage
install -D -m 0644 /home/fciocchetti/Work/booster/generator/booster.img $TARGET_DIR/boot/booster.img
install -D -m 0644 initramfs.img.lz4 $TARGET_DIR/boot/initramfs.img.lz4
install -D -m 0644 rootfs.squashfs $TARGET_DIR/rootfs.squashfs
mkdir -p $TARGET_DIR/Apps/
install -D -m 0755 AppImages/* $TARGET_DIR/Apps/
