#!/bin/bash

#set -x
##conf file import
source /idea_backup/script/default/default_conf

HOSTNAME=`hostname`

#set -x
mysql_sql(){
	local column=$1
	local TABLE=$2
	SELECT_SQL="
	        select USERID from ${TABLE} where USERID = '${column}'
	"
	SQL=${SELECT_SQL}
	#echo $SQL
}


check_info(){
	local column=$1
	mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}" >> A.txt
	cat A.txt | grep -v ${column}
	rm -f A.txt
}


############################### useage
#mysql_sql USERID USER_INFO
#check_info USERID

