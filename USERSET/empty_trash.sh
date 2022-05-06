
#!/bin/bash
 
##conf file import
source /idea_backup/script/default/default_conf

WHOAMI=`whoami`
if [ $WHOAMI != "root" ]; then
        ### if the user is root
        echo -e "${RED} !!!! You are not root permission !!!! ${RESET}"
        exit;
fi


PWD=`pwd`
ls /home | grep d >> $PWD/account.txt

for FILE in `cat $PWD/account.txt`
do
        Trash_DIR=/home/$FILE/.local/share/Trash/files/
        if [ -d "$Trash_DIR" ];then
              rm -rf $Trash_DIR/*
        fi
done

rm -f $PWD/account.txt
