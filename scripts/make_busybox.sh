#!/bin/sh

. ${PROJECT_ROOT}/scripts/tools.sh
. ${PROJECT_ROOT}/scripts/make_envprep.sh

info "Preparing initramfs with Busybox ${PROJECT_BUSYBOX_VERSION}"
PREFIX="[BUSYBOX]"

. ${PROJECT_ROOT}/scripts/busybox/get_busybox.sh
. ${PROJECT_ROOT}/scripts/busybox/build_busybox.sh
