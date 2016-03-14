## Template project for Kernel programming

### Requirements :
* glibc-static

### Setup :

* In resources/Makefile.variable, change :
  * PROJECT_ROOT : as the root folder of the project
  * CORES : set the number of cores to use for project build

### How to :

#### Change Busybox version
In resources/Makefile.variable, change :
* PROJECT_BUSYBOX_VERSION : set the new version of Busybox
* PROJECT_BUSYBOX_SIGN_ID : set the ID of the person who signed Busybox archive

#### Change the Kernel version
In resources/Makefile.variable, change :
* PROJECT_LINUX_VERSION : set the new version of the Kernel
* PROJECT_LINUX_SIGN_ID : set the ID of the person who signed the Kernel archive

### Makefile target
* `kernel` : download (is necessary) and build the Linux kernel

### Build environment
Build environment is made of two parts, the Linux kernel and an initramfs composed
of Busybox and a minimalistic file architecture

#### Kernel
This target download and build the Linux Kernel through the `scripts/make_kernel.sh` script. First, it call `scripts/linux/get_kernel.sh` to download the Linux Kernel indicated in `Makefile.variable`, then it checks the signature using the given key. Thus, `scripts/linux/build_kernel.sh` is called. This script will first generate a kernel `tinyconfig` to create build directory, then copy the default kernel configuration from the `resources` folder (named after the Linux kernel version and fully customizable), and build the kernel. `make modules_prepare` will also be called to prepare out-of-tree module building.

#### Busybox
This target do the same operation as the `kernel` target but with Busybox. This file is downloaded, checked and extract. Then the default configuration is copied and the binaries are built. Thus, Busybox binaries are installed.

##### Default kernel configuration
The default kernel configuration available in `resources` folder is the default `tinyconfig` configuration. Some options are added to a more easy debug :
* fez

##### Build
* Use the configuration file available in resources folder. Name of the file can be changed in Makefile.variable file
* The default config content is the result of `make tinyconfig`
* Before Linux build we call `make prepare`

#### Busybox

### Other
* `make_xxx` scripts are callable script from Makefile
* No scripts should be called manually
* Function from `tools.sh` should only contain error informations
