#!/bin/bash

##conf file import
source /idea_backup/script/default/default_conf

HOSTNAME=`hostname`
DATE=`date +"%y%m%d"`

/idea_backup/script/USERSET/empty_trash.sh
/idea_backup/script/TOOL/fstab_tcp.sh

################# hostname의 끝자리를 이용해 나머지를 구함
get_remainder (){
	local DEVIDE=$1
	LASTNUM=${HOSTNAME: -1}
	#echo $LASTNUM
	REMAINDER=`expr $LASTNUM % $DEVIDE`
}

mount_set_farm () {
	local IP=$1
	local NETAPP=$2

	mkdir -p /${NETAPP}

	POC_COUNT=`cat /etc/fstab | grep ${NETAPP} | wc -l`
	if [ ${POC_COUNT} -eq 0 ] ; then
		echo "### ${NETAPP} poc test storage ###" >> /etc/fstab
		echo -e "10.0.55.${IP}:/vol01     /${NETAPP}	nfs     defaults        0 0" >> /etc/fstab
		echo -e "${GREEN}fstab${RESET}"
		cat /etc/fstab | grep 10.0.55.${IP}
	else
		cat /etc/fstab | grep ${NETAPP}
	fi
}

FARMCOUNT=`hostname | grep farm | wc -l`
CACHECOUNT=`hostname | grep cache | wc -l`
DPXCOUNT=`hostname | grep dpx | wc -l`
ENVCOUNT=`hostname | grep env | wc -l`
HPFXCOUNT=`hostname | grep hpfx | wc -l`
HPRENDERCOUNT=`hostname | grep hprender | wc -l`

if [ ${FARMCOUNT} -eq 1 ] ; then
	mount_set_farm 43 pocnetapp
elif [ ${CACHECOUNT} -eq 1 ] ; then
	mount_set_farm 43 pocnetapp
elif [ ${DPXCOUNT} -eq 1 ] ; then
	mount_set_farm 44 pocnetapp
elif [ ${ENVCOUNT} -eq 1 ] ; then
	mount_set_farm 44 pocnetapp
elif [ ${HPFXCOUNT} -eq 1 ] ; then
	mount_set_farm 44 pocnetapp
elif [ ${HPRENDERCOUNT} -eq 1 ] ; then
	mount_set_farm 43 pocnetapp
fi

#mount /pocnetapp
