#!/bin/bash
 
##conf file import
source /idea_backup/script/default/default_conf
source /idea_backup/script/HEALTHCHECK/RENDERFARM_check/get_seq.sh
#set -x
	
TABLE=CACHE
PING_COUNT=3
TIME=20

NOWTIME=`date +%s`
update(){
	SQL=${UPDATE_SQL}
        mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}"
}

#### table의 seq 최대값 구하기 - for문 카운팅 값에 사용
mysql_sql seq ${TABLE}
get_max_seq seq ${TABLE}
MAXCOUNT=`cat max_seq.txt`

for ((i=1;i<=${MAXCOUNT};i++))
do		
	#### get_seq.sh 에 있는 함수 사용
	mysql_seq_sql ${i} ${TABLE}
	get_farmip_by_seq ${i} ${TABLE}	
	
	#### 현재 진행률 표시
	echo -e "${BOLD}${i} of ${MAXCOUNT}${RESET}"
	IPCOUNT=`cat farmip.txt | wc -l`
	
	#### seq 참조중 빈값이면 넘어감
	if [ ${IPCOUNT} -eq 0 ] ; then
		echo "non"
	else
		FARMIP=`cat farmip.txt`
		COUNT=`ping -c ${PING_COUNT} ${FARMIP} | grep Unreachable | wc -l`
		#### 다운 상태로 업데이트
	        UPDATE_SQL="update ${TABLE} set FLAG=0,MOUNT_FLAG=0,DATE=$NOWTIME where FARMIP='${FARMIP}';"
        	update		
		#### ping으로 통신되는지 확인
		if [ $COUNT = 0 ] ; then
			echo -e "${GREEN}${FARMIP} on${RESET}"
			#### /idea_backup 마운트 확인
			MOUNT_DIR_CHECK=`timeout ${TIME}s sshpass -p${PASSWORD} ssh -o StrictHostKeyChecking=no root@${FARMIP} /idea_backup/script/HEALTHCHECK/RENDERFARM_check/DIR_CHECK.sh`
			if [ ${MOUNT_DIR_CHECK} == "YES" ] ; then
				#### 스토리지 마운트 확인
				MOUNT_COUNT=`timeout ${TIME}s sshpass -p${PASSWORD} ssh -o StrictHostKeyChecking=no root@${FARMIP} /idea_backup/script/USERSET/mount_check.sh |grep not| wc -l`
				if [ ${MOUNT_COUNT} = 0 ] ; then
					UPDATE_SQL="update ${TABLE} set FLAG=1,MOUNT_FLAG=1 where FARMIP='${FARMIP}';"
					update
                        	else
                                	UPDATE_SQL="update ${TABLE} set FLAG=1,MOUNT_FLAG=0 where FARMIP='${FARMIP}';"
                                	update
                        	fi
			else
				#### /idea_backup 마운트 안될 시 스토리지 마운트 안된것이므로 mount_flag=0
				UPDATE_SQL="update ${TABLE} set FLAG=1,MOUNT_FLAG=0 where FARMIP='${FARMIP}';"
                                update
			fi
		else
			echo -e "${RED}${FARMIP} off${RESET}"
		fi
	fi
done

rm -f max_seq.txt
rm -f farmip.txt
