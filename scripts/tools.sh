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

PROGNAME=$(basename $0)
ERROR="\e[0;31m[ERROR]\e[0m"
WARNING="\e[0;33m[WARNING]\e[0m"
INFO="\e[0;32m[INFO]\e[0m"

function info {
	echo -e "${INFO} ${PREFIX} ${1}"
}

function warning {
	echo -e "${WARNING} ${PREFIX} ${1}"
}

function error {
	echo -e "${ERROR} ${PREFIX} ${1}"
}

function move {
	cd $1
	info "==> Move to ${1} folder"
}

# Download a file if not present on the system
# $1 : file to check availability
# $2 : download link for the file
function download_if_not {
	if [ ! -f ${1} ]; then
		warning "No archive found at ${1}, downloading ${2}"
		wget ${2} -O ${1}
	fi
}

# Extract archive and check extraction
# $1 : file to extract
function extract_check {
	tar -xf ${1}
	if [ ! $? -eq 0 ]; then
		error "Could not extract ${1}"
		exit 1
	fi
}

# Check the GPG fingerprint of the file
# $1 : archive
# $2 : sign file
# $3 : sign ID
function gpg_check {
	IS_KEY=`gpg --fingerprint ${3} 2>&1 | grep error | wc -l`
	if [ ! $IS_KEY -eq 0 ]; then
		warning "No key in keyring for ${3}, downloading from keys.gnupg.net"
		gpg --keyserver hkp://keys.gnupg.net --recv-keys ${3} # Get key
	fi

	gpg --decrypt ${2} > /dev/null
	if [ ! $? -eq 0 ]; then
		error "Could not verify signature for ${2}"
		exit 1
	fi

	md5sum -c - <<< "`grep MD5 ${2} | cut -d ' ' -f3` ${1}"
	if [ ! $? -eq 0 ]; then
		error "Bad MD5 checksum for ${1}"
		exit 1
	fi
}

# Check the GPG fingerprint of the Linux kernel archive
# $1 : archive
# $2 : sign file
function kernel_gpg_check {
	xz -cd ${1} | gpg --verify ${2} -

	if [ ! $? -eq 0 ]; then
		error "Bad signature for ${1}"
		exit 1
	fi
}
