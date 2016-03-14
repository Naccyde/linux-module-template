#!/bin/sh

info "Preparing ${PROJECT_LINUX_VERSION} build"

move ${PROJECT_ENV}/${PROJECT_LINUX_VERSION}

# Preparing environment
make O=${PROJECT_ENV}/obj/${PROJECT_LINUX_VERSION} defconfig

# Copy configuration
info "Copy ${PROJECT_LINUX_CONFIGURATION} to kernel build folder"
#cp ${PROJECT_LINUX_CONFIGURATION} ${PROJECT_ENV}/obj/${PROJECT_LINUX_VERSION}/.config
if [ ! $? -eq 0 ]; then
	warning "Configuration copy failed, use tinyconfig instead"
fi

# Make modules_prepare
info "Calling make modules_prepare for ${PROJECT_LINUX_VERSION}"
make O=${PROJECT_ENV}/obj/${PROJECT_LINUX_VERSION} modules_prepare
if [ ! $? -eq 0 ]; then
	error "Could not call modules_prepare for ${PROJECT_LINUX_VERSION}"
fi

# Make Linux
info "Building Linux kernel ${PROJECT_LINUX_VERSION}"
make O=${PROJECT_ENV}/obj/${PROJECT_LINUX_VERSION} -j ${CORES}
if [ ! $? -eq 0 ]; then
	error "Could not build ${PROJET_LINUX_VERSION}"
fi
