#!/bin/bash

source /idea_backup/script/default/default_conf
#set -x

DIR=/idea_backup/script/MYSQL/storage_df/project_df/lustre
TXT=${DIR}/storage_data.txt
COUNT=`cat ${TXT} | wc -l`
NOWTIME=`date +%s`
TABLE=PROJECT_DF_LUSTRE

while [ ${COUNT} != 0 ] ; do
	for ((i=1;i<=2;i++))
	do
        	sed -n "$i,${i}p" ${TXT} > ${DIR}/col_${i}.txt
	done
	sed -i "1,2d" ${TXT} ###### 1~2행 삭제
	
	TEMP_SIZE=`cat ${DIR}/col_1.txt`	#### col_1.txt = size
	SIZE=`expr ${TEMP_SIZE} ` #### 용량 단위 M
	PROJECT_NAME=`cat ${DIR}/col_2.txt`
	
	INSERT_SQL="
	 INSERT INTO ${TABLE} 
	 (PROJECT_NAME, SIZE, DATE)
	 VALUES
	 ('${PROJECT_NAME}',${SIZE},${NOWTIME})
	"

	SQL=${INSERT_SQL}
	#echo -e "${GREEN}${SQL}${RESET}"
	insert_storage_info(){
		mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}"
	}

	insert_storage_info


	COUNT=`cat ${TXT} | wc -l`	#### storage_data.txt 라인 갱신
done

rm -f ${DIR}/col_*
