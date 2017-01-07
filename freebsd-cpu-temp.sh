#!/bin/sh

HOSTNAME="${COLLECTD_HOSTNAME:-localhost}"
INTERVAL="${COLLECTD_INTERVAL:-60}"
 
while sleep "$INTERVAL"; do
   /sbin/sysctl dev.cpu | /usr/bin/grep temperature | /usr/bin/sed -E  "s/^dev.cpu.([0-9]+)..*: ([0-9]+\.[0-9]+)C.*$/PUTVAL \"$HOSTNAME\/cpu-\1\/cpu-temperature\" interval=$INTERVAL N:\2/"
done
