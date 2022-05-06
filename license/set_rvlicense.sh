#!/bin/bash
 
##conf file import
source /idea_backup/script/default/default_conf

HOSTNAME=`hostname`
EMPNO_ALL=/idea_backup/script/default/empno_all.txt
TEAM=`cat $EMPNO_ALL | grep ${HOSTNAME} | awk {'print $2'}`

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

set_RV_license_IP(){
        local RV=$1
	local IP=$2
	local value=$3
	
	if [ ${RV} = ${RV1} ] ; then
		sed -i "s/${IP}/10.0.99.${value}/g" ${RV}/license.gto
	elif [ ${RV} = ${RV2} ] ; then
		sed -i "s/${IP}/10.0.99.${value}/g" ${RV}/license.gto
	fi
	
}

do_funtion(){
      
	local value=$1
        get_RV_license_IP $RV1
        set_RV_license_IP ${RV1} ${RV1_IP} ${value}

        get_RV_license_IP $RV2
	set_RV_license_IP ${RV2} ${RV2_IP} ${value}

	echo -en "${GREEN}RV1 IP : "
	get_RV_license_IP $RV1
	echo "${RV1_IP}"
	echo -en "${GREEN}RV2 IP : "
	get_RV_license_IP $RV2
	echo "${RV2_IP}"
	echo -e "${RESET}"
}

####2DC
if [ ${TEAM} = "2DC" ] ; then
	
	do_funtion 98

####2D1 team 
elif [ ${TEAM} = "2D1" ] ; then

        do_funtion 91

####2D2 team 2D3 team
elif [ ${TEAM} = "2D2" ] || [ $TEAM = 2D3 ] ; then

        do_funtion 92

####2D4 team
elif [ ${TEAM} = "2D4" ] ; then

        do_funtion 93

####2D5 team 2D6 team
elif [ $TEAM = 2D5 ] || [ ${TEAM} = "2D6" ] ; then

        do_funtion 94

####Management IO team
elif [ $TEAM = Digital_Management ] || [ $TEAM = planning ] || [ $TEAM = Previz ] ; then

        do_funtion 95

####Management Pm team
elif [ $TEAM = pm_1 ] ; then

        do_funtion 96

elif [ $TEAM = pm_2 ] ; then

	do_funtion 97

####pipeline team
elif [ $TEAM = pipeline ] || [ ${TEAM} = "IT" ] ; then

	do_funtion 98

####Animation team
elif [ $TEAM = "Animation" ] || [ $TEAM = "CFX" ] ; then

        do_funtion 99

####3D Environment team
elif [ $TEAM = Environment ] ; then

        do_funtion 100

####FX team
elif [ $TEAM = FX_1 ] ; then

        do_funtion 101

elif [ $TEAM = FX_2 ] ; then

        do_funtion 102

####3D Lighting team Modeling
elif [ $TEAM = Lighting ] ; then

        do_funtion 103

elif [ $TEAM = MatchMove ] || [ ${TEAM} = "Modeling" ] ; then

	do_funtion 104

####Production Supervisor team
elif [ $TEAM = Supervisor ] ; then

        do_funtion 105

else
	echo -e "${RED}ADD emp list : /idea_backup/script/default/empno_all.txt ${RESET}"
fi
