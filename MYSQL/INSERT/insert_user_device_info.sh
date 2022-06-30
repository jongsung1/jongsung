#!/bin/bash
#set -x
source /idea_backup/script/default/default_conf

HOSTNAME=`hostname`
##########################################################
OS=`cat /etc/redhat-release`
##########################################################
####CPU_model
cat /proc/cpuinfo | grep "model name" | head -1 > cpu1.txt
awk -F ":" '{print $2}' cpu1.txt > cpu2.txt
cat cpu2.txt | sed 's/^ *//' > cpu3.txt ### 처음 공백제거
CPU=`cat cpu3.txt`
##########################################################
####CPU_core
CPU_CORE=`cat /proc/cpuinfo | grep cores | wc -l`
##########################################################
####DISK
/idea_backup/script/TOOL/disk_info.sh | grep Model > disk1.txt
awk -F ":" '{print $2}' disk1.txt > disk2.txt
cat disk2.txt | sed 's/^ *//' > disk3.txt
DISK=`cat disk3.txt`
##########################################################
free -h -t > free.txt
cat free.txt | grep Mem > free1.txt
awk -F ":" '{print $2}' free1.txt > free2.txt
MEM=`awk -F " " '{print $1}' free2.txt`
##########################################################
####Graphics Card, 
nvidia-smi --query | fgrep 'Product Name' > nvidia1.txt
awk -F ":" '{print $2}' nvidia1.txt > nvidia2.txt
NVIDIA_COUNT=`cat nvidia2.txt| grep NVIDIA | wc -l`
if [ ${NVIDIA_COUNT} -eq 0 ]; then
	cat nvidia2.txt | sed 's/^ *//' > nvidia3.txt
	GPU=`cat nvidia3.txt`
else
	cat nvidia2.txt | sed 's/^ *//' > nvidia3.txt
	awk -F "NVIDIA" '{print $2}' nvidia3.txt > nvidia4.txt
	cat nvidia4.txt | sed 's/^ *//' > nvidia3.txt
	GPU=`cat nvidia3.txt`
fi
##########################################################
####GPU driver version
nvidia-smi --query | fgrep 'Driver Version' > gpuv1.txt
awk -F ":" '{print $2}' gpuv1.txt > gpuv2.txt
cat gpuv2.txt | sed 's/^ *//' > gpuv3.txt
GPU_VERSION=`cat gpuv3.txt`
##########################################################
#### Mainboard-manufacturer
BOARD_COM=`dmidecode -s baseboard-manufacturer | grep -v "#"`
##########################################################
#### Mainboard
BOARD_PRODUCT=`dmidecode -s baseboard-product-name | grep -v "#"`
##########################################################
#### MAC_ADDR
MAC_COUNT=`/idea_backup/script/TOOL/MAC_ADD.sh | wc -l`
if [ ${MAC_COUNT} -eq 1 ]; then
	MAC_ADDR1=`/idea_backup/script/TOOL/MAC_ADD.sh`
	MAC_ADDR2=' '
elif [ ${MAC_COUNT} -eq 2 ]; then
	MAC_ADDR1=`/idea_backup/script/TOOL/MAC_ADD.sh | head -1`
	MAC_ADDR2=`/idea_backup/script/TOOL/MAC_ADD.sh | tail -1`
fi
##########################################################
#### MONITOR
MDIR=/var/log/gdm
#cd ${MDIR}
cat /var/log/gdm/:0.log | grep conn | grep -v disconnected | grep -v client | grep -v failed >> ${MDIR}/test1
cat ${MDIR}/test1 | awk '!x[$0]++' > ${MDIR}/test2
awk -F ":" '{print $2}' ${MDIR}/test2 > ${MDIR}/test3
cat ${MDIR}/test3 | sed 's/^ *//' > ${MDIR}/test4
awk -F "(" '{print $1}' ${MDIR}/test4 > ${MDIR}/test5

MONITOR_COUNT=`cat ${MDIR}/test5 | wc -l`
i=0
while read line
do
        arr_monitor[$i]="$line"
        i=$((i+1))
done < ${MDIR}/test5

MONITOR1=${arr_monitor[0]}
if [ ${MONITOR_COUNT} > 1 ] ; then
	MONITOR2=${arr_monitor[1]}
else
	MONITOR2=""
fi

get_resolution(){
	#### 모든 파라미터 값 받기 // 파라미터 개수를 알지 못해 루프로 받음
	for i in $@
	do
		echo -e "${BACK_BLACK}{BLACK}${i}${RESET}"
	done
	param_length=$# ### 파라미터 길이

	####parameter 값에 따른 모니터 변수 조정
	if [ ${param_length} -eq 2 ] ; then
		MONITOR="$1 $2"
	elif [ ${param_length} -eq 3 ] ; then
		MONITOR="$1 $2 $3"
	elif [ ${param_length} -eq 4 ] ; then
                MONITOR="$1 $2 $3 $4"
	elif [ ${param_length} -eq 5 ] ; then
                MONITOR="$1 $2 $3 $4 $5"
	fi

	if [ "${MONITOR}" == "DELL U2311H" ] ; then
		RESOLUTION="FHD"
	elif [ "${MONITOR}" == "DELL U2312HM" ] ; then
		RESOLUTION="FHD"
	elif [ "${MONITOR}" == "DELL U2410" ] ; then
		RESOLUTION="FHD"
	elif [ "${MONITOR}" == "DELL U2412M" ] ; then
		RESOLUTION="FHD"
	elif [ "${MONITOR}" == "LG Electronics D2743" ] ; then
		RESOLUTION="FHD"
	elif [ "${MONITOR}" == "DELL U2515H" ] ; then
		RESOLUTION="QHD"
	elif [ "${MONITOR}" == "DELL U2518D" ] ; then
		RESOLUTION="QHD"
	elif [ "${MONITOR}" == "DELL U2711" ] ; then
		RESOLUTION="QHD"
	elif [ "${MONITOR}" == "DELL U2713H" ] ; then
		RESOLUTION="QHD"
	elif [ "${MONITOR}" == "DELL U2715H" ] ; then
		RESOLUTION="QHD"
	elif [ "${MONITOR}" == "DELL U2717D" ] ; then
		RESOLUTION="QHD"
	elif [ "${MONITOR}" == "DELL U2718Q" ] ; then
		RESOLUTION="QHD"
	elif [ "${MONITOR}" == "HP Z27x" ] ; then
		RESOLUTION="QHD"
	elif [ "${MONITOR}" == "LG Electronics LG HDR 4K" ] ; then
		RESOLUTION="UHD"
	elif [ "${MONITOR}" == "AUS PA329C" ] ; then
		RESOLUTION="UHD"
	elif [ "${MONITOR}" == "DELL P3222QE" ] ; then
		RESOLUTION="UHD"
	elif [ "${MONITOR}" == "BenQ EW3270U" ] ; then
		RESOLUTION="UHD"
	elif [ "${MONITOR}" == "BenQ PD3200U" ] ; then
		RESOLUTION="UHD"
	elif [ "${MONITOR}" == "Eizo CG318" ] ; then
		RESOLUTION="UHD"
	elif [ "${MONITOR}" == "LG HDR 4K" ] ; then
		RESOLUTION="UHD"
	elif [ "${MONITOR}" == "LG TV" ] ; then
		RESOLUTION="UHD"
	else
		RESOLUTION=""
	fi

}


get_resolution ${MONITOR1}
RESOLUTION1=${RESOLUTION}

echo -e "${GREEN} MONITOR1 : ${MONITOR1} ${RESET}"
echo -e "${GREEN} RESOLUTION1 : ${RESOLUTION1} ${RESET}"

if [ ${MONITOR_COUNT} > 1 ] ; then
	get_resolution ${MONITOR2}
	RESOLUTION2=${RESOLUTION}

        echo -e "${GREEN} MONITOR2 : ${MONITOR2} ${RESET}"
	echo -e "${GREEN} RESOLUTION2 : ${RESOLUTION2} ${RESET}"
fi

##########################################################
DATE=`date +%s`
##########################################################
FLAG=1
##########################################################
if [ ${MONITOR_COUNT} > 1 ] ; then
	INSERT_SQL="

        INSERT INTO USER_DEVICE_INFO
         (USERID, OS, CPU, CPU_CORE,DISK,MEM,GPU,GPU_VERSION,BOARD_COM,BOARD_PRODUCT,DATE,MAC_ADDR1,MAC_ADDR2,FLAG,MONITOR1,RESOLUTION1,MONITOR2,RESOLUTION2)
         VALUES
         ('${HOSTNAME}','${OS}','${CPU}','${CPU_CORE}','${DISK}','${MEM}','${GPU}','${GPU_VERSION}','${BOARD_COM}','${BOARD_PRODUCT}','${DATE}','${MAC_ADDR1}','${MAC_ADDR2}','${FLAG}','${MONITOR1}','${RESOLUTION1}','${MONITOR2}','${RESOLUTION2}');
        "

	UPDATE_SQL="
        UPDATE USER_DEVICE_INFO set
        OS='${OS}',
        CPU='${CPU}',
        CPU_CORE='${CPU_CORE}',
        DISK='${DISK}',
        MEM='${MEM}',
        GPU='${GPU}',
        GPU_VERSION='${GPU_VERSION}',
        BOARD_COM='${BOARD_COM}',
        BOARD_PRODUCT='${BOARD_PRODUCT}',
        DATE='${DATE}',
        FLAG='${FLAG}',
        MONITOR1='${MONITOR1}',
        MONITOR2='${MONITOR2}',
        RESOLUTION1='${RESOLUTION1}',
        RESOLUTION2='${RESOLUTION2}',
        MAC_ADDR1='${MAC_ADDR1}',
        MAC_ADDR2='${MAC_ADDR2}'
        where USERID='${HOSTNAME}';
        "
else

	INSERT_SQL="
	
	INSERT INTO USER_DEVICE_INFO
	 (USERID, OS, CPU, CPU_CORE,DISK,MEM,GPU,GPU_VERSION,BOARD_COM,BOARD_PRODUCT,DATE,MAC_ADDR1,MAC_ADDR2,FLAG,MONITOR1,RESOLUTION1)
	 VALUES
	 ('${HOSTNAME}','${OS}','${CPU}','${CPU_CORE}','${DISK}','${MEM}','${GPU}','${GPU_VERSION}','${BOARD_COM}','${BOARD_PRODUCT}','${DATE}','${MAC_ADDR1}','${MAC_ADDR2}','${FLAG}','${MONITOR1}','${RESOLUTION1}');
	"

	UPDATE_SQL="
	UPDATE USER_DEVICE_INFO set
	OS='${OS}',
	CPU='${CPU}',
	CPU_CORE='${CPU_CORE}',
	DISK='${DISK}',
	MEM='${MEM}',
	GPU='${GPU}',
	GPU_VERSION='${GPU_VERSION}',
	BOARD_COM='${BOARD_COM}',
	BOARD_PRODUCT='${BOARD_PRODUCT}',
	DATE='${DATE}',
	FLAG='${FLAG}',
	MONITOR1='${MONITOR1}',
	RESOLUTION1='${RESOLUTION1}',
	MAC_ADDR1='${MAC_ADDR1}',
	MAC_ADDR2='${MAC_ADDR2}'
	where USERID='${HOSTNAME}';
	"
fi
insert_user_device_info(){
	SQL=${INSERT_SQL}
	#echo -e "${GREEN}$SQL${RESET}"
	mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}"
}

update_user_device_info(){
        SQL=${UPDATE_SQL}
	#echo -e "${GREEN}$SQL${RESET}"
        mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}"
}

####DB에 이미 있는 사용자인지 확인
source /idea_backup/script/MYSQL/INSERT/check_info.sh
#set -x
mysql_sql ${HOSTNAME} USER_DEVICE_INFO
COUNT=`check_info ${HOSTNAME} | wc -l`
if [ ${COUNT} -eq 0 ]; then
	insert_user_device_info
else
	update_user_device_info
fi

rm -f cpu1.txt cpu2.txt cpu3.txt
rm -f disk1.txt disk2.txt disk3.txt
rm -f free.txt free1.txt free2.txt
rm -f nvidia1.txt nvidia2.txt nvidia3.txt nvidia4.txt
rm -f gpuv1.txt gpuv2.txt gpuv3.txt
rm -f /var/log/gdm/test*

echo -e "${GREEN}finish work${RESET}"
