#!/bin/bash

source /idea_backup/script/default/default_conf
#### 사용자 정의 함수 모음
source /idea_backup/script/HEALTHCHECK/USER_CHECK/USER_healthcheck_config.sh

#### USER_healthcheck_config.sh 내부 함수
mysql_sql seq USER_INFO
get_max_seq seq USER_INFO
MAXCOUNT=`cat max_seq.txt`

for ((var=0 ; var <= ${MAXCOUNT} ; var++));
do
	echo -e "${GREEN} ${var} of ${MAXCOUNT} ${RESET}"
	
	mysql_seq_sql $var USER_INFO
	get_ip_by_seq $var USER_INFO
	
	#cat userip.txt
	IPCOUNT=`cat userip.txt | wc -l`

	if [ ${IPCOUNT} -eq 0 ] ; then
		echo "non user"
	else
		#cat userip.txt
		USER_IP=`cat userip.txt`
	        COUNT=`ping -c ${PING_COUNT} ${USER_IP} | grep Unreachable | wc -l`

		if [ $COUNT = 0 ] ; then
			echo -e "${GREEN}${USER_IP} on${RESET}"
			UPDATE_SQL="update ${TABLE} set FLAG=1,DATE=$NOWTIME where USERIP='${USER_IP}';"
	                update

		else
			echo -e "${RED}${USER_IP} off${RESET}"
			UPDATE_SQL="update ${TABLE} set FLAG=0,MOUNT_FLAG=0,DATE=$NOWTIME where USERIP='${USER_IP}';"
			update
		fi
	fi
done

rm -f userip.txt
rm -f max_seq.txt
