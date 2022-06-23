#!/bin/bash

source /idea_backup/script/default/default_conf
#### 사용자 정의 함수 모음
source /idea_backup/script/HEALTHCHECK/USER_CHECK/USER_healthcheck_config.sh

MOUNT_CHECK_DIR=/idea_backup/script/USERSET/

#### USER_healthcheck_config.sh 내부 함수
mysql_sql seq USER_INFO
get_max_seq seq USER_INFO
MAXCOUNT=`cat max_seq.txt`

for ((var=0 ; var <= ${MAXCOUNT} ; var++));
do

	echo -e "${GREEN} ${var} of ${MAXCOUNT} ${RESET}"

	mysql_no_mount_sql ${var} USER_INFO
	get_ip_by_seq ${var} USER_INFO

	IPCOUNT=`cat userip.txt | wc -l`
	USER_IP=`cat userip.txt`
	if [ ${IPCOUNT} -eq 0 ] ; then
		echo "non user"
	else
		sshpass -p${PASSWORD} ssh -o StrictHostKeyChecking=no root@${USER_IP} /idea_backup/script/HEALTHCHECK/USER_CHECK/target/mount_all.sh
		COUNT=`ping -c ${PING_COUNT} ${USER_IP} | grep Unreachable | wc -l`
		if [ $COUNT = 0 ] ; then
			echo -e "${GREEN} ${USER_IP} on${RESET}"
			MOUNT_DIR_CHECK=`timeout ${TIME}s sshpass -p${PASSWORD} ssh -o StrictHostKeyChecking=no root@${USER_IP} /idea_backup/script/HEALTHCHECK/USER_CHECK/DIR_CHECK.sh`
			if [ ${MOUNT_DIR_CHECK} == "YES" ] ; then
				MOUNT_COUNT=`timeout ${TIME}s sshpass -p${PASSWORD} ssh -o StrictHostKeyChecking=no root@${USER_IP} ${MOUNT_CHECK_DIR}/mount_check.sh |grep not| wc -l`
				if [ ${MOUNT_COUNT} = 0 ] ; then
					UPDATE_SQL="update ${TABLE} set FLAG=1,MOUNT_FLAG=1 where USERIP='${USER_IP}';"
					update
				else
					UPDATE_SQL="update ${TABLE} set FLAG=1,MOUNT_FLAG=0 where USERIP='${USER_IP}';"
					update
				fi
			else
				UPDATE_SQL="update ${TABLE} set FLAG=1,MOUNT_FLAG=0 where USERIP='${USER_IP}';"
				update
			fi
			echo -e "${GREEN}uptime check${RESET}"
			timeout ${TIME}s sshpass -p${PASSWORD} ssh -o StrictHostKeyChecking=no root@${USER_IP} /idea_backup/script/HEALTHCHECK/USER_CHECK/get_uptime.sh
	                timeout ${TIME}s sshpass -p${PASSWORD} ssh -o StrictHostKeyChecking=no root@${USER_IP} /idea_backup/script/HEALTHCHECK/USER_CHECK/SIZE_check.sh

		else
			echo -e "${RED} ${USER_IP} off${RESET}"
		fi
	fi
done

