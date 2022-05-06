#!/bin/bash
 
##conf file import
source /idea_backup/script/default/default_conf

#set -x

TEST=N
if [ ${TEST} = "N" ] ; then
	FSTAB=/etc/fstab
elif [ ${TEST} = "Y" ] ; then
	FSTAB=/bootdir/fstab
fi

####### tcp0, tcp1 ==> tcp
TCP_CHANGE(){
        local value=$1
	COUNT=`cat ${FSTAB} | grep UUID | grep ${value} | wc -l`
	if [ ${COUNT} = 0 ] ; then
		cat ${FSTAB} | grep ${value}
		sed -i "s/${value}/tcp/g" ${FSTAB}
	else
		echo -e "${RED}${value} 값이 존재합니다 확인하십시오 ${RESET}"
	fi
}

TCP_CHANGE tcp0
TCP_CHANGE tcp1

cat /etc/fstab | grep tcp0
cat /etc/fstab | grep tcp1
