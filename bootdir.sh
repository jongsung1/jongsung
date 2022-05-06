
#!/bin/bash

GREEN="\\033[1;32m"
BOLD="\\033[1m"
RESET="\\033[0m"
DATE=`date +"%y%m%d"`

mkdir -p /bootdir

tar czf /bootdir/boot_${DATE}.tar.gz /boot /etc/fstab 

tar czf /bootdir/network-scripts_${DATE}.tar.gz /etc/sysconfig/network-scripts

cat /etc/fstab | grep -v "#" | grep -v UUID >> /bootdir/fs

