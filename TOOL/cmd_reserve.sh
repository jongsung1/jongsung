#!/bin/bash

source /idea_backup/script/default/default_conf


#####set TIME
echo -ne "${GREEN}YEAR : ${RESET}"
read YEAR

echo -ne "${GREEN}MONTH : ${RESET}"
read MONTH

echo -ne "${GREEN}DAY : ${RESET}"
read DAY

echo -ne "${GREEN}HOUR : ${RESET}"
read HOUR

echo -ne "${GREEN}MINUTE : ${RESET}"
read MINUTE

echo -ne "${GREEN}SECOND : ${RESET}"
read SECOND

YMD="${YEAR}-${MONTH}-${DAY}"
HMS="${HOUR}:${MINUTE}:${SECOND}"

NOWTIME=`date +%s`
UNIXTIME=`date +%s --date "$YMD $HMS"`

echo -e "${GREEN}${YMD} ${HMS}에 실행 됩니다${RESET}"
date

######설정한 시간이 되면 명령어 실행
while [ ${NOWTIME} -le ${UNIXTIME} ] ; do
	sleep 3
	######현재시간을 갱신하기 위해 생성
	NOWTIME=`date +%s`
done

date

##### command
#echo "nohup_test" >> /home/nohup.txt
/idea_backup/script/system_backup.sh
