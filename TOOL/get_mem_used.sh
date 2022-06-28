#!/bin/bash

##conf file import
source /idea_backup/script/default/default_conf

#########################################
TEMP_LIST=mem_temp.txt
FREE=free.txt
USED=used.txt
USED_TEMP=used_temp.txt
BUFFER=buffers.txt
CACHE=cache.txt
CACHE_TEMP=cache_temp.txt

MULTIPLE=100
#########################################

get_sar(){
	local column=$1
	### 1 -> 01 자리수 맞춤
	if [ $column -lt 10 ] ; then
  	      column="0${column}"
	fi
	sar -r -f /var/log/sa/sa${column} | grep -v Average | grep 0 | grep -v RESTART | grep -v Linux | grep -v kb >> ${TEMP_LIST}
}

get_kbmemfree(){
	cat ${TEMP_LIST} | awk '{print $4}' >> ${FREE}
}

get_kbmemused(){
	cat ${TEMP_LIST} | awk '{print $5}' >> ${USED}
}

get_kbbuffers(){
	cat ${TEMP_LIST} | awk '{print $7}' >> ${BUFFER}
}

get_kbcached(){
	cat ${TEMP_LIST} | awk '{print $8}' >> ${CACHE}
}

echo -en "${GREEN} memory 사용률 점검 시작일 : ${RESET}"
read START

echo -en "${GREEN} memory 사용률 점검 종료일 : ${RESET}"
read END

########################################### 시작일 종료일 유효성 검사
CHECK=$((${END} - ${START}))
if [ $CHECK -lt 0 ] ; then
	echo -e "${RED} 잘못 입력 하셨습니다.${RESET}"
	echo -e "${RED} 시작일이 종료일 보다 클 수 없습니다.${RESET}"
	exit;
fi

########################################### sar 데이터 수집
for ((var=${START} ; var <= ${END} ; var++));
do
	get_sar ${var}
done

get_kbmemfree
get_kbmemused
get_kbbuffers
get_kbcached

LEN=`cat ${FREE} | wc -l`

########################################### insert_array
### arr_free
i=0
while read line
do
	arr_free[$i]="$line"
	i=$((i+1))
done < ${FREE}

### arr_cache
i=0
while read line
do
        arr_cache[$i]="$line"
        i=$((i+1))
done < ${CACHE}

### arr_used
i=0
while read line
do
        arr_used[$i]="$line"
        i=$((i+1))
done < ${USED}

### arr_buffer
i=0
while read line
do
        arr_buffer[$i]="$line"
        i=$((i+1))
done < ${BUFFER}


#for ((var=0 ; var < ${LEN} ; var++));
#do
#        echo ${arr_cache[$var]}
#done

########################################### calculation
############# 평균
TOTAL_MEM=`free | grep ^Mem | awk '{print $2}'`
SUM=0
for ((var=0 ; var < ${LEN} ; var++));
do
	UP=$((${arr_used[$var]} - ${arr_buffer[$var]} - ${arr_cache[$var]}))*${MULTIPLE}
	arr_useage[$var]="$(echo "scale=3; $UP/${TOTAL_MEM}" | bc -l)"
	#echo ${arr_useage[$var]}
	SUM="$(echo "scale=3; ${arr_useage[$var]}+${SUM}" | bc -l)"
done

AVR=$(echo "scale=3; ${SUM}/${MULTIPLE}/${LEN}" | bc -l)
AVR_PER=$(echo "scale=3; ${SUM}/${LEN}" | bc -l)
############# 최대값
TEMP=${arr_useage[0]}
for ((var=0 ; var < ${LEN} ; var++));
do
	if [ `echo "${arr_useage[$var]} >= ${TEMP}" | bc` -eq "1" ] ; then
		TEMP=${arr_useage[$var]}
	fi
done
MAX=$(echo "scale=3; $TEMP/${MULTIPLE}" | bc -l)
MAX_PER=$(echo "scale=3; $TEMP" | bc -l)

echo -e "${BOLD} ${START}일 부터 ${END}일 까지평균 메모리 사용량 : ${AVR_PER} (%) ${RESET}"
echo -e "${BOLD} ${START}일 부터 ${END}일 까지최대 메모리 사용량 : ${MAX_PER} (%) ${RESET}"


rm -f ${TEMP_LIST}
rm -f ${FREE}
rm -f ${USED}
rm -f ${USED_TEMP}
rm -f ${BUFFER}
rm -f ${CACHE}
rm -f ${CACHE_TEMP}

