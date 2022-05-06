#!/bin/bash

##conf file import
source /idea_backup/script/default/default_conf

#####################################
MYSQL=Y		####(Y/N) Y : mysql DB 사용하여 team 정보 갖고오기
		####	  N : mysql DB 작동 하지 않을때 /idea_backup/script/image_backup/empno_all.txt 정보 참조
#####################################

HOSTNAME=`hostname`
DATE=`date +"%y%m%d"`
EMPNO_ALL=/idea_backup/script/POC/empno_all.txt
HEAD=NOWAY
if [ ${MYSQL} = "N" ]; then
	TEAM=`cat $EMPNO_ALL | grep ${HOSTNAME} | awk {'print $2'}`
elif [ ${MYSQL} = "Y" ]; then
	source /idea_backup/script/MYSQL/get_user_info.sh
	mysql_sql TEAM
	TEAM=`get_user_info TEAM`
fi

/idea_backup/script/USERSET/empty_trash.sh
/idea_backup/script/TOOL/fstab_tcp.sh

mount_set () {
	local value=$1
	local value2=$2

	cat /etc/fstab | grep -v IDEA_BACKUP > fstab_${HOSTNAME}.txt
	cat fstab_${HOSTNAME}.txt > /etc/fstab
	rm -f fstab_${HOSTNAME}.txt

	COUNT=`cat /etc/fstab | grep ${value2} | wc -l`
	if [ ${COUNT} -eq 0 ] ; then
		cat /etc/fstab | grep -v poc >> /home/fstab_except_poc.txt
		echo -e "10.0.0.${value}:/gpfs/gs_di/backup/IDEA_BACKUP    /idea_backup    nfs defaults,vers=3  0 0" >> /etc/fstab
		echo -e "${GREEN}fstab${RESET}"
		cat /etc/fstab | grep 10.0.0.${value}
	else
		cat /etc/fstab | grep ${value2}
	fi
}

####2D1 team 2D2 team
if [ $TEAM = 2D1 ] || [ ${TEAM} = "2D2" ] || [ $TEAM = 2D3 ] || [ ${TEAM} = "2D4" ] || [ ${TEAM} = "2D5" ] || [ ${TEAM} = "2D6" ]; then
	
	mount_set 75 IDEA_BACKUP

####2D3 team 2D4 team
elif [ $TEAM = FX ] || [ ${TEAM} = "pipeline" ] || [ ${TEAM} = "Animation" ] || [ ${TEAM} = "IT" ] || [ ${TEAM} = "CFX" ]; then

        mount_set 76 IDEA_BACKUP

####Management IO team
elif [ $TEAM = Digital_Management ] || [ $TEAM = planning ] || [ $TEAM = Previz ] || [ $TEAM = Supervisor ] || [ $TEAM = pmteam ] || [ $TEAM = CEO ]; then

        mount_set 77 IDEA_BACKUP

elif [ $TEAM = Environment ] || [ ${TEAM} = "Lighting" ] || [ ${TEAM} = "MatchMove" ] || [ ${TEAM} = "Modeling" ] || [ ${TEAM} = "2DC" ]; then

        mount_set 78 IDEA_BACKUP

fi

#mount /pocnetapp
