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

start_day="시작일"
end_day="종료일"
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

effectiveness_check(){
	local val=$1
	local day=$2

	NUM_CHECK=`echo "${val}" | grep -E ^\-?[0-9]?\.?[0-9]+$ | wc -l`

	if [ ${NUM_CHECK} -eq 0 ] ; then ## NUM_CHECK = 0
		echo -e "${RED} ${val} 는 문자입니다.${RESET}"
		exit
	else
		if [ ${val} -gt 31 ] ; then ## start > 31
			echo -e "${RED}${day}이 31일보다 클 수 없습니다.${RESET}"
			exit
		elif [ ${val} -lt 1 ] ; then ## start < 1
			echo -e "${RED}${day}이 1일보다 작을 수 없습니다.${RESET}"
			exit
		fi
		echo ${val}
	fi
}

## 달력 표시
cal

echo -en "${GREEN} memory 사용률 점검 시작일 : ${RESET}"
read START
effectiveness_check ${START} ${start_day}

echo -en "${GREEN} memory 사용률 점검 종료일 : ${RESET}"
read END
effectiveness_check ${END} ${end_day}

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

#get_kbmemfree
get_kbmemused
get_kbbuffers
get_kbcached

LEN=`cat ${CACHE} | wc -l`

########################################### insert_array
### arr_free
#i=0
#while read line
#do
#	arr_free[$i]="$line"
#	i=$((i+1))
#done < ${FREE}

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

########################################### calculation
############# 평균
TOTAL_MEM=`free | grep ^Mem | awk '{print $2}'`
SUM=0
SUM_non=0
for ((var=0 ; var < ${LEN} ; var++));
do
	## 실질 메모리 계산
	UP=$((${arr_used[$var]} - ${arr_buffer[$var]} - ${arr_cache[$var]}))*${MULTIPLE}
	#arr_useage[$var]="$(echo "scale=3; $UP/${TOTAL_MEM}" | bc -l)" 
	arr_useage[$var]="$UP"
	SUM="$(echo "scale=3; ${arr_useage[$var]}+${SUM}" | bc -l)"

	##명목상 메모리 계산
	UP_non=${arr_used[$var]}*${MULTIPLE}
	arr_useage_non[$var]="$UP_non"
	SUM_non="$(echo "scale=3; ${arr_useage_non[$var]}+${SUM_non}" | bc -l)"
done

## 실질 메모리 계산
AVR=$(echo "scale=3; ${SUM}/${TOTAL_MEM}/${MULTIPLE}/${LEN}" | bc -l)
AVR_PER=$(echo "scale=3; ${SUM}/${LEN}/${TOTAL_MEM}" | bc -l)

##명목상 메모리 계산
AVR_non=$(echo "scale=3; ${SUM_non}/${MULTIPLE}/${TOTAL_MEM}/${LEN}" | bc -l)
AVR_PER_non=$(echo "scale=3; ${SUM_non}/${LEN}/${TOTAL_MEM}" | bc -l)

############# 최대값
TEMP=${arr_useage[0]}
TEMP_non=${arr_useage_non[0]}
for ((var=0 ; var < ${LEN} ; var++));
do
	## 실질 메모리 계산
	if [ `echo "${arr_useage[$var]} >= ${TEMP}" | bc` -eq "1" ] ; then
		TEMP=${arr_useage[$var]}
	fi
	##명목상 메모리 계산
	if [ `echo "${arr_useage_non[$var]} >= ${TEMP_non}" | bc` -eq "1" ] ; then
                TEMP_non=${arr_useage_non[$var]}
        fi
done

## 실질 메모리 계산
MAX=$(echo "scale=3; $TEMP/${MULTIPLE}/${TOTAL_MEM}" | bc -l)
MAX_PER=$(echo "scale=3; ${MAX}*${MULTIPLE}" | bc -l)

##명목상 메모리 계산
MAX_non=$(echo "scale=3; $TEMP_non/${MULTIPLE}/${TOTAL_MEM}" | bc -l)
MAX_PER_non=$(echo "scale=3; ${MAX_non}*${MULTIPLE}" | bc -l)

echo -e "${BOLD} ${START}일 부터 ${END}일 까지 평균 메모리 사용량 : ${AVR_PER} (%) ${RESET}"
echo -e "${BOLD} ${START}일 부터 ${END}일 까지 최대 메모리 사용량 : ${MAX_PER} (%) ${RESET}"

echo -e "${BOLD} ${START}일 부터 ${END}일 까지 평균 메모리 사용량(명목) : ${AVR_PER_non} (%) ${RESET}"
echo -e "${BOLD} ${START}일 부터 ${END}일 까지 최대 메모리 사용량(명목) : ${MAX_PER_non} (%) ${RESET}"

rm -f ${TEMP_LIST}
rm -f ${FREE}
rm -f ${USED}
rm -f ${USED_TEMP}
rm -f ${BUFFER}
rm -f ${CACHE}
rm -f ${CACHE_TEMP}

