
## Template project for Kernel programming

### Requirements (once repository cloned):
* `gcc`
* `glibc-static`

### Setup :

* In `resources/Makefile.variable`, change :
  * `PROJECT_NAME` : define the name of your project, thus the name of the output module
  * `CORES` : set the number of cores to use for project build (default to 9)
* Be sure to trust and sign theses PGP keys :
  * `gpg --import resources/pgp_keys/00411886.gpg` : Linux Torvalds (for Linux kernel)
  * `gpg --import resources/pgp_keys/6092693E.gpg` : Greg Kroah-Hartman (for some Linux Kernel releases)
  * `gpg --import resources/pgp_keys/ACC9965B.gpg` : Denis Vlasenko (for Busybox)
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
* `clean` : call clean target in the `build` directory
* `mrproper` : remove the `build` directory
* `masterclean` : remove `build` and `env` directories

### More about the build environment
`make env` allow you to create the build and tests environment for your Kernel module.
Calling this command will download necessary packets (actually Busybox and Linux Kernel), extract and build them, so they are ready to be launched from QEMU to test the LKM.

#### Steps for environment creation :
* __Creation of env folder__ : all will be extracted / build in this folder
* __Preparation of Linux__ : download (if necessary) / check signature / extract Linux Kernel / build it
* __Preparation of Busybox__ : download (if necessary) / check signature / extract Busybox / build it
* __Creation of initramfs__ : create the initramfs from Busybox and Unix directories

#### Linux and Busybox download and build are similar, here are the steps :
* First, it call the script to download the sources (`scripts/linux/get_kernel.sh` or `scripts/busybox/get_busybox.sh`) to download the sources indicated in `Makefile.variable`
* Then it checks the signature using the given key (`PROJECT_LINUX_SIGN_ID` or `PROJECT_BUSYBOX_SIGN_ID`)
* Thus, the build script is called (`scripts/linux/build_kernel.sh` or `scripts/busybox/build_busybox.sh`).
   * Linux : this script will first generate a kernel `defconfig` to create build directory, then copy the default kernel configuration from the `resources` folder (named after the Linux kernel version and fully customizable), and build the kernel. `make modules_prepare` will also be called to prepare out-of-tree module building.
   * Busybox : this script will call `make defconfig` on Busybox sources, then copy the default Busybox configuration from the `resources` folder (this configuration is fully customizable), and Busybox will be built. Also, Busybox is built against static glibc.

### Other
* `make_xxx` scripts are callable script from Makefile
* No scripts should be called manually

### About
This project is under the GNU GPLv2 License. See COPYING.

For any suggestion, you can contact `quentin at naccyde dot eu`.

Main repository is available on [my personnal Gitlab](http://git.naccyde.eu/naccyde/linux-module-template)
