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
