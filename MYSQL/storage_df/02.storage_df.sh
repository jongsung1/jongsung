#!/bin/bash

source /idea_backup/script/default/default_conf
#set -x

DIR=/idea_backup/script/MYSQL/storage_df/
TXT=storage_data.txt
COUNT=`cat ${DIR}/${TXT} | wc -l`
NOWTIME=`date +%s`
TABLE=STORAGE_INFO

while [ ${COUNT} != 0 ] ; do
	for ((i=1;i<=6;i++))
	do
        	sed -n "$i,${i}p" ${DIR}/${TXT} > ${DIR}/col_${i}.txt
	done
	cat ${DIR}/col_6.txt | cut -c 2- > ${DIR}/col_7.txt
	mv ${DIR}/col_7.txt ${DIR}/col_6.txt
	sed -i "1,6d" ${DIR}/${TXT}

	NAME_OPT=`cat ${DIR}/col_6.txt | grep opt | wc -l`
	NAME_VOL=`cat ${DIR}/col_6.txt | grep volume1 | wc -l`
	if [ ${NAME_OPT} != 0 ]; then
		awk -F "/" '{print $2}' ${DIR}/col_6.txt > ${DIR}/col_7.txt
		mv ${DIR}/col_7.txt ${DIR}/col_6.txt
		STORAGE_NAME=`cat ${DIR}/col_6.txt`
		#echo -e "${GREEN}${STORAGE_NAME}${RESET}"
	elif [ ${NAME_VOL} != 0 ]; then
		awk -F "/" '{print $2}' ${DIR}/col_6.txt > ${DIR}/col_7.txt
                mv ${DIR}/col_7.txt ${DIR}/col_6.txt
		STORAGE_NAME=`cat ${DIR}/col_6.txt`
                #echo -e "${GREEN}${STORAGE_NAME}${RESET}"
	else
		STORAGE_NAME=`cat ${DIR}/col_6.txt`
                #echo -e "${GREEN}${STORAGE_NAME}${RESET}"
	fi

	
	TEMP_SIZE=`cat ${DIR}/col_2.txt`
	SIZE=`expr ${TEMP_SIZE} / 1024 ` ####용량단위 M
	TEMP_USED=`cat ${DIR}/col_3.txt`
	USED=`expr ${TEMP_USED} / 1024 ` ####용량단위 M
	TEMP_AVAIL=`cat ${DIR}/col_4.txt`
	AVAIL=`expr ${TEMP_AVAIL} / 1024 ` ####용량단위 M
	USED_PER=`cat ${DIR}/col_5.txt`

	INSERT_SQL="
	 INSERT INTO ${TABLE} 
	 (STORAGE_NAME, SIZE, USED, AVAIL, USED_PER, DATE)
	 VALUES
	 ('${STORAGE_NAME}',${SIZE},${USED},${AVAIL},'${USED_PER}',${NOWTIME})
	"

	SQL=${INSERT_SQL}
	#echo -e "${GREEN}${SQL}${RESET}"
	insert_storage_info(){
		mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}"
	}

	insert_storage_info


	COUNT=`cat ${DIR}/${TXT} | wc -l`
done

rm -f ${DIR}/col_*
