#!/bin/bash
 
##conf file import
source /idea_backup/script/default/default_conf
#set -x
	

TABLE=FARM
C_CLASS=70
D_CLASS=40
PING_COUNT=3
TIME=20

NOWTIME=`date +%s`
update(){
	SQL=${UPDATE_SQL}
        mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}"
}

for ((i=1;i<=${D_CLASS};i++))
do		
	FARMIP="10.0.${C_CLASS}.$i"
	COUNT=`ping -c ${PING_COUNT} ${FARMIP} | grep Unreachable | wc -l`		
	UPDATE_SQL="update ${TABLE} set FLAG=0,MOUNT_FLAG=0,DATE=$NOWTIME where FARMIP='${FARMIP}';"
	update

	if [ $COUNT = 0 ] ; then
		echo -e "${GREEN}${FARMIP} on${RESET}"	
		MOUNT_COUNT=`timeout ${TIME}s sshpass -p${PASSWORD} ssh -o StrictHostKeyChecking=no root@${FARMIP} /idea_backup/script/USERSET/mount_check.sh |grep not| wc -l`
		if [ ${MOUNT_COUNT} -eq 0 ] ; then
			UPDATE_SQL="update ${TABLE} set FLAG=1,MOUNT_FLAG=1 where FARMIP='${FARMIP}';"
		else
			UPDATE_SQL="update ${TABLE} set FLAG=1,MOUNT_FLAG=0 where FARMIP='${FARMIP}';"
		fi
		update
		#echo -e "${RED}${SQL}${RESET}"
	else			
		echo -e "${RED}${FARMIP} off${RESET}"		
	fi	
done
