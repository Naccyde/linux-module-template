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

# Download appropriate Kernel & sign file
info "${PROJECT_LINUX_VERSION} download..."
download_if_not ${PROJECT_LINUX_ARCHIVE} ${PROJECT_LINUX_ARCHIVE_LINK}
download_if_not ${PROJECT_LINUX_SIGN_FILE} ${PROJECT_LINUX_SIGN_FILE_LINK}

# Check Kernel signature
info "${PROJECT_LINUX_VERSION} GPG signature check"
kernel_gpg_check ${PROJECT_LINUX_ARCHIVE} ${PROJECT_LINUX_SIGN_FILE}

# Extract Kernel properly
info "${PROJECT_LINUX_VERSION} extraction"
extract_check ${PROJECT_LINUX_ARCHIVE}

