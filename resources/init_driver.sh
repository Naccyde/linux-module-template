#!/bin/sh

mount -t proc none /proc
mount -t sysfs none /sys

echo -e "Boot finish ($(cut -d' ' -f1 /proc/uptime)s)\n"

insmod dogedriver.ko
export PS1=""

exec /bin/sh