#!/bin/sh

HOSTNAME="${COLLECTD_HOSTNAME:-localhost}"
INTERVAL="${COLLECTD_INTERVAL:-60}"
SUDO=/usr/local/bin/sudo
while sleep "$INTERVAL"; do
    for disk in `$SUDO /sbin/camcontrol devlist | /usr/bin/sed -E 's/^.*\\((.*),.*/\\1/'`; do
        temp=`$SUDO /usr/local/sbin/smartctl -a /dev/$disk  | grep Temperature_Celsius | awk '{ print $10; }'` 
        echo "PUTVAL \"$HOSTNAME/disk-$disk/temperature\" interval=$INTERVAL N:$temp"
    done
done
