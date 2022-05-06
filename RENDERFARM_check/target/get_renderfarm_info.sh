#!/bin/bash

##conf file import
source /idea_backup/script/default/default_conf
DIR=`pwd`

#set -x
mysql_sql(){
	local column=$1
	local table=$2

	SELECT_SQL="
	        select ${column} from ${table} where FLAG = 0 or MOUNT_FLAG = 0
	"
	SQL=${SELECT_SQL}
	#echo $SQL
}


get_renderfarm_info(){
	local column=$1
	local table=$2

	mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}" > ${DIR}/${table}_tmp.txt
	cat ${DIR}/${table}_tmp.txt | grep -v ${column} > ${DIR}/${table}.txt
	rm -f ${DIR}/${table}_tmp.txt
}

#get_user_info USERNAME
#get_user_info USERIP
#get_user_info TEAM

mysql_sql FARMIP CACHE
get_renderfarm_info FARMIP CACHE

mysql_sql FARMIP DPX
get_renderfarm_info FARMIP DPX

mysql_sql FARMIP ENV
get_renderfarm_info FARMIP ENV

mysql_sql FARMIP FARM
get_renderfarm_info FARMIP FARM

mysql_sql FARMIP HPFX
get_renderfarm_info FARMIP HPFX

mysql_sql FARMIP HPRENDER
get_renderfarm_info FARMIP HPRENDER







