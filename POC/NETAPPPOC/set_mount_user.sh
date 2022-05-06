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
	mkdir -p /${value2}

	POC_COUNT=`cat /etc/fstab | grep ${value2} | wc -l`
	if [ ${POC_COUNT} -eq 0 ] ; then
		cat /etc/fstab | grep -v poc >> /home/fstab_except_poc.txt
		echo "### poc netapp storage ###" >> /etc/fstab
		echo -e "10.0.55.${value}:/vol01     /${value2}	nfs     defaults        0 0" >> /etc/fstab
		echo -e "${GREEN}fstab${RESET}"
		cat /etc/fstab | grep 10.0.55.${value}
	else
		cat /etc/fstab | grep ${value2}
	fi
}

####2D1 team 2D2 team
if [ ${TEAM} = "2DC" ] || [ ${TEAM} = "2D1" ] || [ ${TEAM} = "2D2" ]; then
	
	mount_set 43 pocnetapp

####2D3 team 2D4 team
elif [ $TEAM = 2D3 ] || [ ${TEAM} = "2D4" ]; then

        mount_set 44 pocnetapp

####2D5 team 2D6 team
elif [ $TEAM = 2D5 ] || [ ${TEAM} = "2D6" ]; then

        mount_set 43 pocnetapp

####FX team
elif [ $TEAM = FX ] ; then

        mount_set 44 pocnetapp

####3D Environment team
elif [ $TEAM = Environment ] ; then

        mount_set 43 pocnetapp

####3D Lighting team Modeling
elif [ $TEAM = Lighting ] ; then

        mount_set 44 pocnetapp

elif [ $TEAM = CFX ] || [ ${TEAM} = "Modeling" ]; then

	mount_set 43 pocnetapp

####3D MatchMove team
elif [ $TEAM = MatchMove ] || [ $TEAM = Animation ] ; then

        mount_set 44 pocnetapp

####pipeline team
elif [ $TEAM = pipeline ] || [ ${TEAM} = "IT" ]; then

        mount_set 43 pocnetapp

####Production Supervisor team
elif [ $TEAM = Supervisor ] ; then

        mount_set 44 pocnetapp

####Management Pm team
elif [ $TEAM = pm_1 ] || [ $TEAM = pm_2 ]; then

        mount_set 43 pocnetapp

####Management IO team
elif [ $TEAM = Digital_Management ] || [ $TEAM = planning ] || [ $TEAM = Previz ]; then

        mount_set 44 pocnetapp

fi

#mount /pocnetapp
