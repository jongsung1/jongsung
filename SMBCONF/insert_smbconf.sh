

#!/bin/bash

##conf file import
source /idea_backup/script/default/default_conf

## when the source server does not have sshpass rpm
COUNT=`rpm  -qa | grep sshpass | wc -l`
if [ $COUNT = 0 ]; then
        if [ $WHO = root ]; then
                yum install -y sshpass-1.06-2.el7.x86_64
        else
                sbr /idea_backup/script/SMBCONF/yum_sshpass.sh
        fi
fi


#set -x

##target server infomation
#ID="root"
#PASSWORD="rhdid8cmd!"
HOST="10.0.200.100"
#HOST="10.0.28.14"


## use sshpass , excute "SMBCONF.sh" in target server
## useage
sshpass -p${PASSWORD} ssh -o StrictHostKeyChecking=no ${ID}@${HOST} sh /idea_backup/script/SMBCONF/SMBCONF.sh;sleep 30
