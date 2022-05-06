#!/bin/bash
source /idea_backup/script/default/default_conf
HOSTNAME=`hostname`

cat /etc/fstab | grep -v poc > fstab_${HOSTNAME}.txt
cat fstab_${HOSTNAME}.txt > /etc/fstab
rm -f fstab_${HOSTNAME}.txt

umount /pocnetapp

echo -e "${GREEN}DONE${RESET}"

/idea_backup/script/USERSET/mount_check.sh

rm -rf /hppoc
rm -rf /pocnetapp

