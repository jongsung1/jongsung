#!/bin/bash

##conf file import
source /idea_backup/script/default/default_conf

WHOAMI=`whoami`
if [ $WHOAMI != "root" ]; then
        ### if the user is root
        echo -e "${RED} !!!! You are not root permission !!!! ${RESET}"
        exit;
fi


USERID=`who |grep DIGITALIDEA |awk {'print $1'}|uniq | cut -d '\' -f2`
COUNT=`diff /idea_backup/script/default/user-dirs.dirs /home/$USERID/.config/user-dirs.dirs | wc -l`

if [ $COUNT != 0 ]; then
	rm -f /home/$USERID/.config/user-dirs.dirs
	cp /idea_backup/script/default/user-dirs.dirs /home/$USERID/.config/
fi
