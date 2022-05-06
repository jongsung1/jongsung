#!/bin/bash

##conf file import
source /idea_backup/script/default/default_conf

set -x
sql(){
	local USERID=$1
	local TABLE=$2
	DELETE_SQL="
	        delete from ${TABLE} where USERID = '${USERID}'
	"
	SQL=${DELETE_SQL}
}

delete(){
	mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}" 
}



echo -ne "${GREEN}삭제 할 사용자 사번 :  ${RESET}"
read USERID

echo -en "${RED}${USERID}를 삭제하시겠습니까 (Y/N) : ${RESET}"
read choice
case "$choice" in
	"Y" | "y"| "yes")        
		sql ${USERID} USER_INFO
		delete

		sql ${USERID} USER_DEVICE_INFO
		delete			
	;;
	"N" | "n"| "no")
		echo -e "${RED}you select No.${RESET}"
	;;
	*)        
		echo -e "!! You have wrong answer !! you have to answer yes or no."
	esac;
