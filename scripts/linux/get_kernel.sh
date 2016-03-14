#!/bin/sh

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

