#!/bin/bash

#####################################
##최종 수정일
## 2022-07-01
## LIST에 있는 확장명 파일을 제외한 나머지 파일은 tar로 묶임
## 파일을 제외한 디렉토리만 묶어 복사하기 위한 작업임

##확장명 추가
## 확장명 추가 파일 
LIST=list.txt  ## 확장명
LIST2=list2.txt  ## exclude + 확장명 
PROJECT_DIR=/lustre3/show/
PROJECT_DIR2=/netapp/show/
PWD=`pwd`
EXCLUDE_ALL=""
#####################################

##conf file import
source /idea_backup/script/default/default_conf

########## LIST 파일에 있는 내용 --exclude=* 붙여 LIST2에 저장
LEN=`cat ${LIST} | wc -l`
for FILE in `cat $LIST`
do
        echo "--exclude=*${FILE}" >> ${LIST2}
done

########## LIST2 내용을 EXCLUDE_ALL 변수에 합성
for FILE in `cat $LIST2`
do
        a=${FILE}
	EXCLUDE_ALL="${EXCLUDE_ALL} $a"
done

tar_system () {
	local dir=$1
	cd ${PROJECT_DIR}/${PROJECT}

        tar zcpvf backup_${dir}.tar.gz $EXCLUDE_ALL ${dir}
	sleep 1
}

tar_system_netapp () {
	local dir=$1
	cd ${PROJECT_DIR2}/${PROJECT}

        tar zcpvf backup_${dir}.tar.gz $EXCLUDE_ALL ${dir}
	sleep 1
}

echo -en "${GREEN} insert PROJECT name :  ${RESET}"
read PROJECT

echo -e "${GREEN}  Is it right? ${PROJECT} (Y/N)  ${RESET}"
read CHOICE
case "$CHOICE" in        
	"Y" | "y" | "yes")        
		echo -e "${GREEN} config ${RESET}"
		tar_system config
		echo -e "${GREEN} preproduction ${RESET}"
		tar_system preproduction
		echo -e "${GREEN} product ${RESET}"
		tar_system product
		echo -e "${GREEN} seq ${RESET}"
		tar_system seq
		echo -e "${GREEN} tmp ${RESET}"
		tar_system tmp

		echo -e "${GREEN} assets ${RESET}"
		tar_system_netapp assets

	;;
	*)        
		echo -e "!! Nothing will happen !!"
	esac;

