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
	mkdir -p /hppoc

	POC_COUNT=`cat /etc/fstab | grep hppoc | wc -l`
	if [ ${POC_COUNT} -eq 0 ] ; then
		cat /etc/fstab | grep -v poc >> /home/fstab_except_poc.txt
		echo "### poc test storage ###" >> /etc/fstab
		echo -e "10.0.55.${IP}:/nfs_test /hppoc nfs intr,hard,tcp,rw 0 0" >> /etc/fstab
		echo -e "${GREEN}fstab${RESET}"
		cat /etc/fstab | grep 10.0.55.${IP}
	else
		cat /etc/fstab | grep hppoc
	fi
}

FARMCOUNT=`hostname | grep farm | wc -l`
CACHECOUNT=`hostname | grep cache | wc -l`
DPXCOUNT=`hostname | grep dpx | wc -l`
ENVCOUNT=`hostname | grep env | wc -l`
HPFXCOUNT=`hostname | grep hpfx | wc -l`
HPRENDERCOUNT=`hostname | grep hprender | wc -l`

if [ ${FARMCOUNT} -eq 1 ] ; then
	##### %2
	get_remainder 2

	if [ ${REMAINDER} -eq 0 ] ; then
		mount_set_farm 55
	elif [ ${REMAINDER} -eq 1 ] ; then
		mount_set_farm 56
	else
		echo "maybe user"
	fi
elif [ ${CACHECOUNT} -eq 1 ] ; then
	##### %1
        get_remainder 1

        if [ ${REMAINDER} -eq 0 ] ; then
                mount_set_farm 55
        else
                echo "maybe user"
	fi
elif [ ${DPXCOUNT} -eq 1 ] ; then
        ##### %1
        get_remainder 1
	if [ ${REMAINDER} -eq 0 ] ; then
                mount_set_farm 56
	else
                echo "maybe user"
	fi
elif [ ${ENVCOUNT} -eq 1 ] ; then
        ##### %3
        get_remainder 3
	if [ ${REMAINDER} -eq 0 ] ; then
                mount_set_farm 57
        elif [ ${REMAINDER} -eq 1 ] ; then
                mount_set_farm 58
	elif [ ${REMAINDER} -eq 2 ] ; then
                mount_set_farm 59
        else
                echo "maybe user"
        fi
elif [ ${HPFXCOUNT} -eq 1 ] ; then
        ##### %3
        get_remainder 3
        if [ ${REMAINDER} -eq 0 ] ; then
                mount_set_farm 60
        elif [ ${REMAINDER} -eq 1 ] ; then
                mount_set_farm 61
        elif [ ${REMAINDER} -eq 2 ] ; then
                mount_set_farm 62
        else
                echo "maybe user"
        fi
elif [ ${HPRENDERCOUNT} -eq 1 ] ; then
        ##### %4
        get_remainder 4
        if [ ${REMAINDER} -eq 0 ] ; then
                mount_set_farm 63
        elif [ ${REMAINDER} -eq 1 ] ; then
                mount_set_farm 64
        elif [ ${REMAINDER} -eq 2 ] ; then
                mount_set_farm 65
	elif [ ${REMAINDER} -eq 3 ] ; then
                mount_set_farm 66
        else
                echo "maybe user"
        fi
fi

