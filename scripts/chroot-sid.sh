#!/bin/bash

mount /dev/thinkpad-vg/root-debian-sid /mnt/sid
for i in dev dev/pts proc sys run; do
    mount --bind /$i /mnt/sid/$i
done

