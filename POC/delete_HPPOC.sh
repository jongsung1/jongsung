#!/bin/bash

HOSTNAME=`hostname`

cat /etc/fstab | grep -v poc > fstab_${HOSTNAME}.txt
cat fstab_${HOSTNAME}.txt > /etc/fstab
rm -f fstab_${HOSTNAME}.txt

#/idea_backup/script/POC/NETAPPPOC/set_mount_user.sh
/idea_backup/script/POC/NETAPPPOC/set_mount_farm.sh
