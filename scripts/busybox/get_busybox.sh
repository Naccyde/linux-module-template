#!/bin/sh

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
