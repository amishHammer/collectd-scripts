#!/bin/sh

HOSTNAME="${COLLECTD_HOSTNAME:-localhost}"
INTERVAL="${COLLECTD_INTERVAL:-60}"
SUDO=/usr/local/bin/sudo
while sleep "$INTERVAL"; do
    MFIBUS=`sudo camcontrol devlist -b | grep mfi | awk '{ print $1; }'`
    for disk in `$SUDO /sbin/camcontrol devlist | grep $MFIBUS | /usr/bin/sed -E 's/^.*\\(([a-z]+[0-9]+).*/\\1/'`; do
        temp=`$SUDO /usr/local/sbin/smartctl -a /dev/$disk  | grep "Current Drive Temperature" | awk '{ print $4; }'`
        echo "PUTVAL \"$HOSTNAME/disk-$disk/temperature\" interval=$INTERVAL N:$temp"
    done
done
