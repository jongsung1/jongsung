#!/bin/bash

source /idea_backup/script/default/default_conf

### renew LIST
/idea_backup/script/HEALTHCHECK/USER_CHECK/get_user_info.sh
LIST=/idea_backup/script/HEALTHCHECK/USER_CHECK/check_list.txt
TABLE=USER_INFO
PING_COUNT=3
TIME=20

NOWTIME=`date +%s`
update(){
        SQL=${UPDATE_SQL}
        mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}"
} 


for FILE in `cat $LIST`
do
	COUNT=`ping -c ${PING_COUNT} ${FILE} | grep Unreachable | wc -l`
	UPDATE_SQL="update ${TABLE} set FLAG=0,MOUNT_FLAG=0,DATE=$NOWTIME where USERIP='${FILE}';"
	update
	
	if [ $COUNT = 0 ] ; then
		echo -e "${GREEN}${FILE} on${RESET}"
		MOUNT_COUNT=`timeout ${TIME}s sshpass -p${PASSWORD} ssh -o StrictHostKeyChecking=no root@${FILE} /idea_backup/script/USERSET/mount_check.sh |grep not| wc -l`
		if [ ${MOUNT_COUNT} = 0 ] ; then
			UPDATE_SQL="update ${TABLE} set FLAG=1,MOUNT_FLAG=1 where USERIP='${FILE}';"
			update
		else
			UPDATE_SQL="update ${TABLE} set FLAG=1,MOUNT_FLAG=0 where USERIP='${FILE}';"
			update
		fi
	else
		echo -e "${RED}${FILE} off${RESET}"
	fi
done

