#!/bin/bash

##conf file import
source /idea_backup/script/default/default_conf

HOSTNAME=`hostname`
WHOAMI=`whoami`

ADJOIN=/opt/ad_setup/
PBIS=/opt/pbis/bin/
DATE=`date +%s`

if [ $WHOAMI != "root" ]; then
        ### if the user is root
        echo -e "${RED} !!!! You are not root permission !!!! ${RESET}"
        exit;
fi

insert_history(){
	TABLE=PBIS_HISTORY
	INSERT_SQL=" INSERT INTO ${TABLE} (USERID, DATE) VALUES ('${HOSTNAME}','${DATE}') "
	SQL=${INSERT_SQL}
	mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}"
}

insert_history

pbis_reinstall () {
	if [ $WHOAMI != "root" ] ; then
	        echo -e "${RED}you need root${RESET}"
	else
	        ## pbis dismiss
		echo -e "${GREEN}It take some time${RESET}"
	        cd $PBIS
	        ./uninstall.sh purge
		
		cd /opt
		rm -rf pbis-open*

	        ## ad_join setting
	        cd $ADJOIN
	        ./ad_setup_el7.py
	fi
}

pbis_check () {
	PBIS_COUNT=`/opt/pbis/bin/find-user-by-name d10169@digitalidea.co.kr | grep Name | wc -l`
	if [ ${PBIS_COUNT} == 1 ] ; then
		echo -e "${GREEN}logout and re-check${RESET}"
		exit;
	fi
}

pbis_check
echo -e "${GREEN}hostname : ${HOSTNAME}${RESET}"
echo -ne "${GREEN}insert your employee number :  ${RESET}"
read EMPNO

if [ -z $EMPNO ]; then
	### if EMPNO name is null
        echo -e "${RED} !!!! insert your employee number !!!! ${RESET}"
	exit;
fi

echo -e "${GREEN}Is it right? ${EMPNO} (Y/N) ${RESET}"
read emp_choice

echo -e "${GREEN}reboot after install (Y/N) ${RESET}"
read boot_choice
	
case "$emp_choice" in        
	"Y" | "y")        
		pbis_reinstall
		gpasswd -a DIGITALIDEA\\${EMPNO} idea
		case "$boot_choice" in
		        "Y" | "y" | "yes")
				reboot
			;;
			*)
				echo -e "${RED}you have to reboot this system.${RESET}"
			esac;
	;;
	"N" | "n")
		echo -e "!!Chek your employee number !!"
	;;
	*)        
		echo -e "!! Nothing will happen !!"
	esac;
