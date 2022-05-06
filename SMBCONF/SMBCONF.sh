

#!/bin/bash

################################################
#2021-12-06
#config 추가에서 아래 내용 삭제
#        vfs objcet = full_audit
#        full_audit:priority = LOCAL1
#        full_audit:facility = LOCAL1
#        full_audit:failure =  mkdir rmdir pwrite rename unlink
#        full_audit:success = mkdir rmdir pwrite rename unlink
#        full_audit:prefix = %u|%U|%I|%m|%S
################################################

#set -x

GREEN="\\033[1;32m"
BOLD="\\033[1m"
RED="\\033[1;31m"
RESET="\\033[0m"

## samba conf file dir
SMBCONF=/etc/samba/smb.conf
#SMBCONF=/home/smb.conf

##### This is funtion to insert config to smb.conf##########
insert_conf(){
        echo "
[show_$PROJECT]
        path = /lustre3/show/$PROJECT
        writeable = yes
        browseable = yes
        create mask = 0775
        directory mask = 0775
        " >> $SMBCONF
}
##############################################################

## read project name
echo -ne "${GREEN}Please write the project name : ${RESET}"
read PROJECT

## NULL POINT check
if [ -z $PROJECT ]; then
	### if PROJECT name is null
        echo -e "${RED} PROJECT name is null !!!! ${RESET}"

else

	### if PROJECT name is not null
	## count whether the project exist or not
	COUNT=`cat $SMBCONF | grep $PROJECT | wc -l`

	## project is not exist in config, then insert config to smb.conf
	## project is exist in config, do nothing
	if [ $COUNT = 0 ]; then
        	insert_conf
	        service smb restart
	        echo -e "${GREEN}This ${PROJECT} project is inserted${RESET}"
	        cat $SMBCONF | grep $PROJECT

	else

	        echo -e "${RED}This ${PROJECT} project already exists${RESET}"
	        #echo -e "${RED}${PROJECT}${RESET}"
	        cat $SMBCONF | grep $PROJECT
	fi

fi

