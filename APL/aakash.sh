#!/system/bin/sh

export bin=/system/bin
export PATH=$bin:/usr/bin:/usr/sbin:/bin:$PATH
export TERM=linux
export HOME=/root
export MNT=/data/local/linux

if [ ! -d $MNT ]
then
mkdir -p $MNT
fi


busybox chroot $MNT /bin/bash -c "mkdir /proc"
busybox chroot $MNT /bin/bash -c "mkdir /sys"
busybox chroot $MNT /bin/bash -c "mkdir -p /dev/pts"

busybox mount -t devpts devpts $MNT/dev/pts
busybox mount -t proc proc $MNT/proc
busybox mount -t sysfs sysfs $MNT/sys

busybox  chroot  $MNT /bin/bash -c "chown -R www-data.www-data /var/www/html"
busybox  chroot  $MNT /bin/bash -c "chown -R www-data.www-data /usr/lib/cgi-bin"
busybox  chroot  $MNT /bin/bash -c "rm /dev/null"
busybox  chroot  $MNT /bin/bash -c "rm /var/run/apache2/*"
busybox  chroot  $MNT /bin/bash -c "service apache2 stop"
busybox  chroot  $MNT /bin/bash -c "service apache2 start"
busybox  chroot  $MNT /bin/bash -c "rm /tmp/.X1-*" 
busybox chroot $MNT /bin/bash -c "nohup Xvfb :1 -screen 0 640x480x24 -ac < /dev/null > Xvfb.out 2> Xvfb.err &"

#busybox umount $MNT/proc 
#busybox umount $MNT/sys
