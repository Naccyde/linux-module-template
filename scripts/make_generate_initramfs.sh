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

. ${PROJECT_ROOT}/scripts/tools.sh
. ${PROJECT_ROOT}/scripts/make_envprep.sh

cd ${PROJECT_ENV}/initramfs/${PROJECT_BUSYBOX_VERSION}

cp ${PROJECT_ROOT}/build/${PROJECT_NAME}.ko module.ko

find . -print0 \
	| cpio --null -ov --format=newc \
	| gzip -9 > ${PROJECT_ENV}/obj/initramfs-${PROJECT_BUSYBOX_VERSION}.cpio.gz

cd -
