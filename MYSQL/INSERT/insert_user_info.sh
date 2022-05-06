#!/bin/bash
source /idea_backup/script/default/default_conf
HOSTNAME=`hostname`
IP=`/idea_backup/script/TOOL/active_network.sh`

echo -e "${GREEN}${HOSTNAME}${RESET}"
echo -ne "${GREEN}insert EMPNO : ${RESET}"
read EMPNO

NAMECOUNT=`/opt/pbis/bin/find-user-by-name ${EMPNO}@digitalidea.co.kr | grep Gecos | awk '{print $3$4}' | wc -l`

if [ ${NAMECOUNT} = 0 ]; then
	echo -ne "${GREEN}insert USERNAME in English: ${RESET}"
	read USERNAME
else
	USERNAME=`/opt/pbis/bin/find-user-by-name ${EMPNO}@digitalidea.co.kr | grep Gecos | awk '{print $3$4}'`
fi

echo -e "${GREEN}${IP}${RESET}"
echo -ne "${GREEN}insert USERIP : ${RESET}"
read USERIP

echo "
IT                
2DC               
2D1               
2D2               
2D3               
2D4               
2D5               
2D6               
FX                
pipeline          
Animation         
CFX               
Environment       
Lighting          
MatchMove         
Modeling          
Previz            
Supervisor        
Digital_Management
planning          
pmteam            
CEO               
"
echo -ne "${GREEN}insert USER_TEAM : ${RESET}"
read USER_TEAM

COL_EMPNO=${EMPNO}
COL_USERNAME=${USERNAME}
COL_USERIP=${USERIP}
COL_USER_TEAM=${USER_TEAM}

INSERT_SQL="
 INSERT INTO USER_INFO
 (USERID, USERNAME, USERIP, TEAM,ATTR,PASSWORD)
 VALUES
 ('${COL_EMPNO}','${COL_USERNAME}','${COL_USERIP}','${COL_USER_TEAM}',1,'298b0b8911571ff40a095a6438d44f4253c4d9bd2f7b9b19e50d6e3fff1d8022f9dbffd0fb2b3be37391eba88dfeb50f4e0dc212cb2fe3aae5b8213b1bbe32ca')
"

UPDATE_SQL="
UPDATE USER_INFO set 

USERID='${COL_EMPNO}',			
USERNAME='${COL_USERNAME}',			
USERIP='${COL_USERIP}',			
TEAM='${COL_USER_TEAM}'

where USERID='${COL_EMPNO}'
"

insert_user_info(){
	SQL=${INSERT_SQL}
	mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}"
}

update_user_info(){
	SQL=${UPDATE_SQL}
        mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}"
}

####DB에 이미 있는 사용자인지 확인
source /idea_backup/script/MYSQL/INSERT/check_info.sh
mysql_sql ${EMPNO} USER_INFO
#check_info USERID
COUNT=`check_info ${EMPNO} | wc -l`
if [ ${COUNT} -eq 0 ]; then
	echo -e "${GREEN}${SQL}${RESET}"
	echo -en "${RED}Are you sure to insert? (Y/N) : ${RESET}"
	read choice
	case "$choice" in
		"Y" | "y"| "yes")
			insert_user_info
		;;
		"N" | "n"| "no")
			echo -e "${RED}you select No.${RESET}"
	        ;;
		*)        
			echo -e "!! You have wrong answer !! you have to answer yes or no."
		esac;
else
	update_user_info
fi
