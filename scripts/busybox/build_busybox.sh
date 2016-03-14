#!/bin/sh

info "Preparing userland build"

move ${PROJECT_ENV}/${PROJECT_BUSYBOX_VERSION}

# Preparing environment
mkdir -pv ${PROJECT_ENV}/obj/${PROJECT_BUSYBOX_VERSION}
make O=${PROJECT_ENV}/obj/${PROJECT_BUSYBOX_VERSION} defconfig

# Copy default config
info "Copy ${PROJECT_BUSYBOX_VERSION} to Busybox build folder"
cp ${PROJECT_BUSYBOX_CONFIGURATION} ${PROJECT_ENV}/obj/${PROJECT_BUSYBOX_VERSION}/.config
if [ ! $? -eq 0 ]; then
	warning "Configuration copy failed, generating default configuration"
	make O=${PROJECT_ENV}/obj/${PROJECT_BUSYBOX_VERSION} defconfig
fi

# Make Busybox
info "Building Busybox ${PROJECT_BUSYBOX_VERSION}"
make O=${PROJECT_ENV}/obj/${PROJECT_BUSYBOX_VERSION} -j ${CORES}
if [ ! $? -eq 0 ]; then
	error "Could not build ${PROJECT_BUSYBOX_VERSION}"
fi

# Install Busybox
info "Installing ${PROJECT_BUSYBOX_VERSION}"
cd ${PROJECT_ENV}/obj/${PROJECT_BUSYBOX_VERSION}
make install
if [ ! $? -eq 0 ]; then
	error "Could not install ${PROJECT_BUSYBOX_VERSION}"
fi
