#!/bin/sh

# This file is part of linux-module-template.
#
# linux-module-template is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# linux-module-template is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Foobar.  If not, see <http://www.gnu.org/licenses/>.

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
