#!/bin/bash
 
##conf file import
source /idea_backup/script/default/default_conf

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
if [ ${MONITOR_COUNT} -eq 2 ] ; then
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

if [ ${MONITOR_COUNT} -eq 2 ] ; then
        get_resolution ${MONITOR2}
        RESOLUTION2=${RESOLUTION}

        echo -e "${GREEN} MONITOR2 : ${MONITOR2} ${RESET}"
        echo -e "${GREEN} RESOLUTION2 : ${RESOLUTION2} ${RESET}"
fi


rm -f ${MDIR}/test*
