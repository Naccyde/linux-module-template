#!/bin/sh

echo -e ${INFO}" Preparing initramfs creation"
mkdir -p $DOGE_TOP/initramfs/$DOGE_BUSYBOX_V
cd $DOGE_TOP/initramfs/$DOGE_BUSYBOX_V

# Prepare directories to generate initramfs
echo -e ${INFO}" Creating initramfs directories"
mkdir -p {bin,sbin,etc,proc,sys,usr/{bin,sbin}}
cp -a $DOGE_TOP/obj/$DOGE_BUSYBOX_V/_install/* .

echo nameserver 80.67.169.12 > etc/resolv.conf
