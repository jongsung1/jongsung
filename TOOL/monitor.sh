#!/bin/bash
 
##conf file import
source /idea_backup/script/default/default_conf

#set -x
cd /var/log/gdm
grep -r "NVIDIA" | grep -v dis | grep -v fail | grep conn | grep 0.log: | awk '!x[$0]++'

