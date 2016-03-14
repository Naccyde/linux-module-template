#!/bin/sh

echo -e ${INFO}" Preparing ${DOGE_BUSYBOX_V} build"
cd $DOGE_TOP/$DOGE_BUSYBOX_V
mkdir -pv $DOGE_TOP/obj/$DOGE_BUSYBOX_V


# Default Busybox configuration
echo -e ${INFO}" Creating default ${DOGE_BUSYBOX_V} config"
make O=../obj/$DOGE_BUSYBOX_V defconfig
if [ ! $? -eq 0 ]; then
	echo -e ${ERROR}" Could not create default ${DOGE_BUSYBOX_V} config"
	exit 1
fi

# Copy old config
echo -e ${INFO}" Copying configuration to ${DOGE_TOP}/obj/${DOGE_BUSYBOX_V}"
cp ${DOGE_ROOT}/resources/${DOGE_BUSYBOX_V}.config ${DOGE_TOP}/obj/${DOGE_BUSYBOX_V}/.config
if [ ! $? -eq 0 ]; then
	echo -e ${ERROR}" No Linux configuration found at ${DOGE_ROOT}/resources/${DOGE_BUSYBOX_V}.config"
	exit 1
fi

cd $DOGE_TOP/obj/$DOGE_BUSYBOX_V
 
# Build Busybox
echo -e ${INFO}" Building ${DOGE_BUSYBOX_V}"
make -j ${CORES}
if [ ! $? -eq 0 ]; then
	echo -e ${ERROR}" Could not build ${DOGE_BUSYBOX_V}"
	exit 1
fi


# Install Busybox
echo -e ${INFO}" Installing ${DOGE_BUSYBOX_V}"
make install
if [ ! $? -eq 0 ]; then
	echo -e ${ERROR}" Could not install ${DOGE_BUSYBOX_V}"
	exit 1
fi

