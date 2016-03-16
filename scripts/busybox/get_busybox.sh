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

# Download Busybox archive and sign file
info "${PROJECT_BUSYBOX_VERSION} download..."
download_if_not ${PROJECT_BUSYBOX_ARCHIVE} ${PROJECT_BUSYBOX_ARCHIVE_LINK}
download_if_not ${PROJECT_BUSYBOX_SIGN_FILE} ${PROJECT_BUSYBOX_SIGN_FILE_LINK}

# Check Busybox signature
info "${PROJECT_BUSYBOX_VERSION} GPG signature check"
gpg_check ${PROJECT_BUSYBOX_ARCHIVE} ${PROJECT_BUSYBOX_SIGN_FILE} ${PROJECT_BUSYBOX_SIGN_ID}

# Extract sources
info "${PROJECT_BUSYBOX_VERSION} extraction"
extract_check ${PROJECT_BUSYBOX_ARCHIVE}
