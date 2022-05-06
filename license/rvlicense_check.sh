#!/bin/bash
#set -x
##conf file import

source /idea_backup/script/default/default_conf

HOSTNAME=`hostname`

/idea_backup/script/USERSET/empty_trash.sh

#set -x
RV1=/opt/rv-Linux-x86-64-7.0.0/etc/
RV2=/opt/rv-Linux-x86-64-7.2.0/etc/

####### 91 start ~ 107 end
get_RV_license_IP(){
        local value=$1
	
	A=${value}/1.txt
	B=${value}/2.txt
	C=${value}/3.txt

	if [ ${value} = ${RV1} ] ; then			
		sed -n "/host/ p" ${value}/license.gto >> ${A}
		awk -F "=" '{print $2}' ${A} >> ${B}
		awk -F '"' '{print $2}' ${B} >> ${C}
		RV1_IP=`cat ${C}`	######## RV1_IP
		rm -f ${A} ${B} ${C}
	elif [ ${value} = ${RV2} ] ; then	
                sed -n "/host/ p" ${value}/license.gto >> ${A}
                awk -F "=" '{print $2}' ${A} >> ${B}
                awk -F '"' '{print $2}' ${B} >> ${C}
		RV2_IP=`cat ${C}`	######## RV2_IP
		rm -f ${A} ${B} ${C}
	fi
}

echo -en "${GREEN}RV1 IP : "
get_RV_license_IP $RV1
echo "${RV1_IP}"
echo -en "${GREEN}RV2 IP : "
get_RV_license_IP $RV2
echo "${RV2_IP}"
echo -e "${RESET}"
