#!/bin/sh
PATH=/sbin:/bin:/usr/sbin:/usr/bin
mount -t proc proc /proc
mount -t devtmpfs none /dev
mount -t sysfs sysfs /sys

rootdev=""
opt="rw"
wait=""
nfsroot=""
nfsopts=""
for bootarg in `cat /proc/cmdline`; do
    case "$bootarg" in
    root=*) rootdev="${bootarg##root=}" ;;
    nfsroot=*)
            nfsroot=$(echo ${bootarg##nfsroot=} | cut -d ',' -f 1)
            nfsopts=$(echo ${bootarg##nfsroot=} | cut -d ',' -f 2-)
            nfsopts=${nfsopts##${nfsroot}}
            ;;
    ro) opt="ro" ;;
    rootwait) wait="yes" ;;
    esac
done
if [ -n "$wait" -a ! -b "${rootdev}" ]; then
    echo "Waiting for ${rootdev}..."
    count=0
    while [ $count -lt 25 ]; do
    test -b "${rootdev}" && break
    sleep 0.1
    count=`expr $count + 1`
    done
fi
echo "Mounting ${rootdev}..."
if [ "$rootdev" = "/dev/nfs" ]; then
    echo "Using NFS to boot..."
    mount -t nfs -o "${opt},${nfsopts}" "${nfsroot}" /mnt || exec sh
else
    mount -t ext4 -o "$opt" "${rootdev}" /mnt || exec sh
fi
echo "Switching to rootfs on ${rootdev}..."
mount --move /sys  /mnt/sys
mount --move /proc /mnt/proc
mount --move /dev  /mnt/dev
exec switch_root /mnt /sbin/init
