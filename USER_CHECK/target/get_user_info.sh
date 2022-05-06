#!/bin/bash

##conf file import
source /idea_backup/script/default/default_conf
DIR=/idea_backup/script/HEALTHCHECK/USER_CHECK/target
#set -x
mysql_sql(){
	local column=$1
	local table=$2

	SELECT_SQL="
	        select ${column} from ${table} where FLAG=1 and MOUNT_FLAG=0 and OS='L'
	"
	SQL=${SELECT_SQL}
	#echo $SQL
}


get_user_info(){
	local column=$1
	local table=$2

	mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}" > ${DIR}/${table}_tmp.txt
	cat ${DIR}/${table}_tmp.txt | grep -v ${column} > ${DIR}/check_list.txt
	rm -f ${DIR}/${table}_tmp.txt
}

#get_user_info USERNAME
#get_user_info USERIP
#get_user_info TEAM

mysql_sql USERIP USER_INFO
get_user_info USERIP USER_INFO








