Requirements


## Template project for Kernel programming

### Requirements (once repository cloned):
* `gcc`
* `glibc-static`
* fe

### Setup :

* In `resources/Makefile.variable`, change :
  * `PROJECT_NAME` : define the name of your project, thus the name of the output module
  * `CORES` : set the number of cores to use for project build (default to 9)
* Be sure to trust and sign theses PGP keys :
  * `00411886` : Linux Torvalds (for Linux kernel)
  * `6092693E` : Greg Kroah-Hartman (for some Linux Kernel releases)
  * `ACC9965B` : Denis Vlasenko (for Busybox)
* Then, call `make env` to prepare build environment

Also, source files are in `src` folder and headers are in `include` folder.

### How to :

#### Change Busybox version
In `resources/Makefile.variable`, change :
* PROJECT_BUSYBOX_VERSION : set the new version of Busybox
* PROJECT_BUSYBOX_SIGN_ID : set the ID of the person who signed Busybox archive
* Also, be sure to check the files URL (`PROJECT_BUSYBOX_ARCHIVE_LINK` and `PROJECT_BUSYBOX_SIGN_FILE_LINK`)

#### Change the Kernel version
In `resources/Makefile.variable`, change :
* PROJECT_LINUX_VERSION : set the new version of the Kernel
* PROJECT_LINUX_SIGN_ID : set the ID of the person who signed the Kernel archive
* Also, be sure to check the files URL (`PROJECT_LINUX_ARCHIVE_LINK` and `PROJECT_LINUX_SIGN_FILE_LINK`)

#### Change Busybox configuration
In `resources/Makefile.variable`, change :
* `PROJECT_BUSYBOX_CONFIGURATION` : set the name of the configuration file. By default, the file is location to `${PROJECT_ROOT}/resources/sources/`

#### Change Linux kernel configuration
In `resources/Makefile.variable`, change :
* `PROJECT_LINUX_CONFIGURATION` : set the name of the configuration file. By default, the file is location to `${PROJECT_ROOT}/resources/sources/`


### Makefile targets
* `all` : call `project` target
* `project` : build the project in `build` directory
* `test` : build an initramfs with the built module (if available), then start a QEMU session with the fresh Linux Kernel and the initramfs. You can the insert your module through the shell or change the init script (`${PROJECT_ROOT}/resources/init`) to insert the module at boot
* `kernel` : download (if necessary) and build the Linux kernel with provided configuration (called in `make env`)
* `busybox` : download (if necessary) and build Busybox with provided configuraiton (called in `make env`)
* `initramfs` : generate the initramfs directories for the RAM filesystem
* `env` : generate build environment by building Linux kernel, Busybox and initramfs
* `generate_initramfs` : this target is called when using `make test`, it create the initramfs cpio archive with the lastest module built

### Build environment
Build environment is made of two parts, the Linux kernel and an initramfs composed
of Busybox and a minimalistic file architecture

#### Kernel
This target download and build the Linux Kernel through the `scripts/make_kernel.sh` script. First, it call `scripts/linux/get_kernel.sh` to download the Linux Kernel indicated in `Makefile.variable`, then it checks the signature using the given key. Thus, `scripts/linux/build_kernel.sh` is called. This script will first generate a kernel `tinyconfig` to create build directory, then copy the default kernel configuration from the `resources` folder (named after the Linux kernel version and fully customizable), and build the kernel. `make modules_prepare` will also be called to prepare out-of-tree module building.

#### Busybox
This target do the same operation as the `kernel` target but with Busybox. This file is downloaded, checked and extract. Then the default configuration is copied and the binaries are built. Thus, Busybox binaries are installed.
Busybox is build with static glib

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
