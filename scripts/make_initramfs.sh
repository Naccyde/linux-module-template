#!/bin/sh

. ${PROJECT_ROOT}/scripts/tools.sh
. ${PROJECT_ROOT}/scripts/make_envprep.sh

info "Preparing  initramfs with Busybox ${PROJECT_BUSYBOX_VERSION}"
PREFIX="[INITRAMFS]"

info "Preparing initramfs creation"
mkdir -p ${PROJECT_ENV}/initramfs/${PROJECT_BUSYBOX_VERSION}
cd ${PROJECT_ENV}/initramfs/${PROJECT_BUSYBOX_VERSION}

# Prepare directories to generate initramfs
info "Creating initramfs directories"
mkdir -p {bin,sbin,etc,proc,sys,usr/{bin,sbin}}
cp -a ${PROJECT_ENV}/obj/${PROJECT_BUSYBOX_VERSION}/_install/* .

echo nameserver 80.67.169.12 > etc/resolv.conf

info "Copy init file"
cp ${PROJECT_ROOT}/resources/init ${PROJECT_ENV}/initramfs/${PROJECT_BUSYBOX_VERSION}/init

chmod +x ${PROJECT_ENV}/initramfs/${PROJECT_BUSYBOX_VERSION}/init
