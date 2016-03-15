#!/bin/sh

. ${PROJECT_ROOT}/scripts/tools.sh
. ${PROJECT_ROOT}/scripts/make_envprep.sh

cd ${PROJECT_ENV}/initramfs/${PROJECT_BUSYBOX_VERSION}

cp ${PROJECT_ROOT}/build/${PROJECT_NAME}.ko module.ko

find . -print0 \
	| cpio --null -ov --format=newc \
	| gzip -9 > ${PROJECT_ENV}/obj/initramfs-${PROJECT_BUSYBOX_VERSION}.cpio.gz

cd -
