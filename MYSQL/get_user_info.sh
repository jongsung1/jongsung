#!/bin/bash

##conf file import
source /idea_backup/script/default/default_conf

HOSTNAME=`hostname`

#set -x
mysql_sql(){
	local column=$1
	SELECT_SQL="
	        select ${column} from USER_INFO where USERID = '${HOSTNAME}'
	"
	SQL=${SELECT_SQL}
	#echo $SQL
}


get_user_info(){
	local column=$1
	mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}" >> A.txt
	cat A.txt | grep -v ${column}
	rm -f A.txt
}

#get_user_info USERNAME
#get_user_info USERIP
#get_user_info TEAM

#mysql_sql USERIP
#IPADDR=`get_user_info USERIP`


