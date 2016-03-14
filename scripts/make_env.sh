#!/bin/sh

. $PROJECT_ROOT/scripts/tools.sh
. $PROJECT_ROOT/scripts/make_envprep.sh

# Get sources
. $PROJECT_ROOT/scripts/busybox/make_getbusybox.sh

#
# Make userland, initramfs & kernel
$DOGE_ROOT/scripts/make_userland.sh
if [ ! $? -eq 0 ]; then
	exit 1
fi

$DOGE_ROOT/scripts/make_setup_initramfs.sh
$DOGE_ROOT/scripts/make_initramfs.sh
if [ ! $? -eq 0 ]; then
	exit 1
fi

. $PROJECT_ROOT/scripts/make_kernel.sh
