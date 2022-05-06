#!/bin/bash

source /idea_backup/script/default/default_conf

#####set TIME
YMD="2023-04-29"
HMS="22:00:00"

NOWTIME=`date +%s`
UNIXTIME=`date +%s --date "$YMD $HMS"`

echo -e "${GREEN}${YMD} ${HMS}에 shutdown 됩니다${RESET}"
date

######설정한 시간이 되면 명령어 실행
while [ ${NOWTIME} -le ${UNIXTIME} ] ; do
	sleep 3
	######현재시간을 갱신하기 위해 생성
	NOWTIME=`date +%s`
done

date

##### command
shutdown -h now
