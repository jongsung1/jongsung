#!/bin/bash

##conf file import
source /idea_backup/script/default/default_conf

#########################################
LIST=idle.txt
RESULT=USED.txt
FINAL=RESULT.txt
MULLTI=100
#########################################

get_sar(){
	local column=$1
	### 1 -> 01 자리수 맞춤
	if [ $column -lt 10 ] ; then
  	      column="0${column}"
	fi
	sar -f /var/log/sa/sa${column} | grep -v Average | grep -v CPU | grep -v RESTART|grep all >> tmp.txt
}

get_idle(){
	awk -F "     " '{print $8}' tmp.txt >> ${LIST}
}

cal

echo -en "${GREEN} cpu 사용률 점검 시작일 : ${RESET}"
read START

echo -en "${GREEN} cpu 사용률 점검 종료일 : ${RESET}"
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
get_idle

########################################### 100-idle list 수집
for FILE in `cat $LIST`
do
	a=100
	b=${FILE}

	###### 0.xx 표시가 안되서 100 곱한 후 최종 연산에서 100으로 나눔
	echo "scale=3; ($a - $b) * ${MULLTI}" | bc -l >> ${RESULT}
done

#### 평균을 구하기 위한 나눌 수
x=`cat ${LIST} | wc -l` 

########################################### 수집한 idle list 더하기// 평균cpu 사용량
a=0
for FILE in `cat ${RESULT}`
do
	b=${FILE}
	tmp=$(echo "scale=3; $a + $b" | bc -l)
	a=${tmp}
done

avr=$(echo "scale=3; $a/${MULLTI}/${x}" | bc -l)
echo $avr > ${FINAL}
echo -e "${BOLD} ${START}일 부터 ${END}일 까지CPU 평균 사용량 : $avr (%) ${RESET}" 

########################################### 수집한 idle list 배열에 추가 후 값 비교// 최대 cpu 사용량
#set -x
i=0
while read line 
do
        arr_max[$i]="$line"
        i=$((i+1))
done < ${RESULT}

TEMP=${arr_max[0]}
for ((var=0 ; var < ${x} ; var++));
do
	#echo ${arr_max[$var]}
	#set -x
	if [ `echo "${arr_max[$var]} >= ${TEMP}" | bc` -eq "1" ] ; then
		TEMP=${arr_max[$var]}
	fi
done
max=$(echo "scale=3; $TEMP/${MULLTI}" | bc -l)
echo -e "${BOLD} ${START}일 부터 ${END}일 까지CPU 최대 사용량 : ${max} (%) ${RESET}"

rm -f ${RESULT}
rm -f $LIST
rm -f tmp.txt
rm -f ${FINAL}

