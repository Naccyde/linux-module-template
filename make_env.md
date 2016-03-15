# Make env system

## What is it ?
`make env` allow you to create the build and tests environment for this Kernel module.
Calling this command will download necessary packets (actually Busybox and Linux Kernel), extract and build them, so they are ready to be launched from QEMU to test the LKM.  
If you do not want to test the DOGE-Stack in this specific environment you should nevertheless build the Linux Kernel from sources to build the DOGE-Stack, or you can change `KDIR` variable in `Makefile.variable` to your distribution Kernel sources.

## Steps for environment creation :
* __Creation of env folder__ : all will be extracted / build in this folder
* __Preparation of Busybox__ : download / check signature / extract Busybox
* __Preparation of Linux__ : download / check signature / extract Linux Kernel
* __Creation of userland__ : creation of Busybox default configuration and build / install
* __Creation of initramfs__ : create the initramfs from Busybox and Unix directories
* __Build of the Linux Kernel__ : build Linux Kernel from a configuration and install it

## About sources signature :
Source signature is a blocking feature when making tests environment. If sources signature could not be checked, environment will not be build. There is actually two differents way for sources signing verification :
* __Busybox way__ : Busybox developer who sign sources provide is key at http://busybox.net/~vda/vda_pubkey.gpg or we can use its ID `ACC9965B`
* __Linux Kernel way__ : users who sign sources (currently Linus Torvalds) have their pubkey into public keys repositories, so :
 `gpg --keyserver hkp://keys.gnupg.net --recv-keys ${key}`  
   should do the work.  
   Don't forget to set `DOGE_LINUX_SIGN_ID` to the proper ID in `Makefile.variable`
   
