# DOGE Stack Module Makefile

include resources/Makefile.variable

.PHONY: env

all: project

project:
	cp -r src build
	cp resources/Makefile.build build/Makefile

	$(MAKE) -C build -j ${CORES}

tmp_test: initramfs
	sudo qemu-system-x86_64 \
	-kernel env/obj/${DOGE_LINUX_V}/arch/x86_64/boot/bzImage \
	-initrd env/obj/initramfs-${DOGE_BUSYBOX_V}.cpio.gz \
	-device pci-assign,host=07:00.0 \
	-enable-kvm -nographic -append "ip=dhcp console=ttyS0 rd.shell=1 intel_iommu=on"

## TOOLS
kernel:
	. scripts/make_kernel.sh

busybox:
	. scripts/make_busybox.sh

initramfs:
	. scripts/make_initramfs.sh

env:
	. scripts/make_kernel.sh
	. scripts/make_busybox.sh
	. scripts/make_initramfs.sh

tmp_clean:
	$(MAKE) -C build clean

tmp_mrproper:
	rm -rf build

tmp_masterclean: mrproper
	rm -rf env
