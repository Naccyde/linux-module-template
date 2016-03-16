# DOGE Stack Module Makefile

include resources/Makefile.variable

.PHONY: env

all: project

project:
	test -d build || mkdir build
	cp -r src build
	cp resources/Makefile.build build/Makefile

	$(MAKE) -C build -j ${CORES}

test: generate_initramfs
	qemu-system-x86_64 \
	-kernel env/obj/${PROJECT_LINUX_VERSION}/arch/x86_64/boot/bzImage \
	-initrd env/obj/initramfs-${PROJECT_BUSYBOX_VERSION}.cpio.gz \
	-enable-kvm -nographic -append "console=ttyS0 rd.shell=1 intel_iommu=on"

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

generate_initramfs:
	. scripts/make_generate_initramfs.sh

clean:
	$(MAKE) -C build clean

mrproper:
	rm -rf build

masterclean: mrproper
	rm -rf env
