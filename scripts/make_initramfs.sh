#!/bin/sh

. ${PROJECT_ROOT}/scripts/tools.sh
. ${PROJECT_ROOT}/scripts/make_envprep.sh

info "Preparing  initramfs with Busybox ${PROJECT_BUSYBOX_VERSION}"
PREFIX="[INITRAMFS]"

info "Creating initramfs directories"
mkdir -p ${PROJECT_ENV}/initramfs/${PROJECT_BUSYBOX_VERSION}
cd ${PROJECT_ENV}/initramfs/${PROJECT_BUSYBOX_VERSION}

mkdir -p {bin,sbin,etc,proc,sys,usr/{bin,sbin}}
cp -a ${PROJECT_ENV}/obj/${PROJECT_BUSYBOX_VERSION}/_install/* .

# FDN DNS FTW
echo nameserver 80.67.169.12 > etc/resolv.conf

info " Creating initramfs to ${PROJECT_ENV}/obj/initramfs-${PROJECT_BUSYBOX_VERSION}.cpio.gz"
cd ${PROJECT_ENV}/initramfs/${PROJECT_BUSYBOX_VERSION}
cp ${PROJECT_ROOT}/resources/init init

chmod +x init

find . -print0 \
	| cpio --null -ov --format=newc \
	| gzip -9 > ${PROJECT_ENV}/obj/initramfs-${PROJECT_BUSYBOX_VERSION}.cpio.gz
if [ ! $? -eq 0 ]; then
	error "Could not create initramfs"
fi

