#!/bin/sh

. ${PROJECT_ROOT}/scripts/tools.sh
. ${PROJECT_ROOT}/scripts/make_envprep.sh

info "Preparing Linux Kernel ${PROJECT_LINUX_VERSION}"
PREFIX="[LINUX]"

. ${PROJECT_ROOT}/scripts/linux/get_kernel.sh
. ${PROJECT_ROOT}/scripts/linux/build_kernel.sh
