#!/bin/bash

#set -x
source /idea_backup/script/default/default_conf

### renew LIST
TABLE=USER_INFO
PING_COUNT=3
TIME=20
DIR=`pwd`

NOWTIME=`date +%s`
update(){
        SQL=${UPDATE_SQL}
        mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}"
}

get_ip_by_seq(){
        local column=$1
        local table=$2
        mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}" > ${DIR}/${table}_userip_tmp.txt
	cat ${DIR}/${table}_userip_tmp.txt |  grep -v USERIP > userip.txt
	rm -f ${DIR}/${table}_userip_tmp.txt
}

mysql_seq_sql(){
        local column=$1
        local table=$2
        SELECT_SQL="select USERIP from ${table} where seq='${column}' and OS='L';"
        SQL=${SELECT_SQL}
}


mysql_sql(){
        local column=$1
        local table=$2
        SELECT_SQL="select max(${column}) from ${table} ;"
        SQL=${SELECT_SQL}
}

get_max_seq(){
        local column=$1
        local table=$2
        mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}" > ${DIR}/${table}_seq_tmp.txt
        cat ${DIR}/${table}_seq_tmp.txt | grep -v ${column} > max_seq.txt
        rm -f ${DIR}/${table}_seq_tmp.txt
}

mysql_sql seq USER_INFO
get_max_seq seq USER_INFO
MAXCOUNT=`cat max_seq.txt`

for ((var=0 ; var <= ${MAXCOUNT} ; var++));
do
	echo -e "${GREEN}${var} of ${MAXCOUNT}${RESET}"
	
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
        	UPDATE_SQL="update ${TABLE} set FLAG=0,MOUNT_FLAG=0,DATE=$NOWTIME where USERIP='${USER_IP}';"
	        update

		if [ $COUNT = 0 ] ; then
			echo -e "${GREEN}${USER_IP} on${RESET}"
			MOUNT_COUNT=`timeout ${TIME}s sshpass -p${PASSWORD} ssh -o StrictHostKeyChecking=no root@${USER_IP} /idea_backup/script/USERSET/mount_check.sh |grep not| wc -l`
			if [ ${MOUNT_COUNT} = 0 ] ; then
				UPDATE_SQL="update ${TABLE} set FLAG=1,MOUNT_FLAG=1 where USERIP='${USER_IP}';"
				update
			else
				UPDATE_SQL="update ${TABLE} set FLAG=1,MOUNT_FLAG=0 where USERIP='${USER_IP}';"
				update
			fi
			echo -e "${GREEN}uptime check${RESET}"
			timeout ${TIME}s sshpass -p${PASSWORD} ssh -o StrictHostKeyChecking=no root@${USER_IP} /idea_backup/script/HEALTHCHECK/USER_CHECK/get_uptime.sh
			timeout ${TIME}s sshpass -p${PASSWORD} ssh -o StrictHostKeyChecking=no root@${USER_IP} /idea_backup/script/HEALTHCHECK/USER_CHECK/SIZE_check.sh
		else
			echo -e "${RED}${USER_IP} off${RESET}"
		fi
	fi
done

rm -f userip.txt
rm -f max_seq.txt
