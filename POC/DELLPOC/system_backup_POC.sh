#!/bin/bash

#####################################
##최종 수정일
##2022-01-13
##2022-01-13 QUICK_BACKUP 구문 추가
##2022-01-17 팀별 분류방식 변경
##2022-02-24 팀별 program backup dir
##2022-03-29 팀 선택 방식 변경 - mysql에서 선택(옵션 처리)
##2022-03-31 저장 디렉토리 예외처리 추가 
##		/lustre3/image_backup/USER 경로가 없을 경우 
##		/idea_backup/image_backup_temp에 저장
#####################################

##conf file import
source /idea_backup/script/default/default_conf

#####################################
SEED_BACKUP=N   ####(Y/N) Y : /home/USERID/Desktop/ 경로제외
                ####      N : 제외 없이 모두 백업
#####################################
QUICK_BACKUP=N	####(Y/N) Y : /home/USERID/Desktop/ 경로의 크기가 10G 이상일 경우 백업 경로 제외 
		####	  N : 제외 없이 모두 백업
#####################################
MYSQL=Y		####(Y/N) Y : mysql DB 사용하여 team 정보 갖고오기
		####	  N : mysql DB 작동 하지 않을때 /idea_backup/script/image_backup/empno_all.txt 정보 참조
#####################################

HOSTNAME=`hostname`
DATE=`date +"%y%m%d"`
HISTORY=history.txt
DIR=/lustre3/image_backup/USER
if [ -d "${DIR}" ];then
	BKDIR=${DIR}
else
	BKDIR=/idea_backup/image_backup_temp
fi
EMPNO_ALL=/idea_backup/script/image_backup/empno_all.txt
HEAD=NOWAY

if [ ${MYSQL} = "N" ]; then
	TEAM=`cat $EMPNO_ALL | grep ${HOSTNAME} | awk {'print $2'}`
elif [ ${MYSQL} = "Y" ]; then
	source /idea_backup/script/MYSQL/get_user_info.sh
	mysql_sql TEAM
	TEAM=`get_user_info TEAM`
fi

EMPNO_check=`who |grep DIGITALIDEA |awk {'print $1'}|uniq | cut -d '\' -f2`
if [ -z $EMPNO_check ]; then
	EMPNO=idea
else
	EMPNO=`who |grep DIGITALIDEA |awk {'print $1'}|uniq | cut -d '\' -f2`
fi

EXCLUDE1="--exclude=/L_backup/* --exclude=/proc/* --exclude=/lost+found/* --exclude=/media/* --exclude=/mnt/* --exclude=/sys/* --exclude=/var/log/* --exclude=/run/media/*  --exclude=/boot/* --exclude=/icebackup*/* --exclude=/var/spool/* --exclude=/bootdir/*"

EXCLUDE2="--exclude=/lustre/* --exclude=/lustre2/* --exclude=/lustre3/* --exclude=/old_backup/* --exclude=/old_backup2/* --exclude=/INSA/*"

EXCLUDE3="--exclude=/netapp/* --exclude=/clib2/* --exclude=/clib/* --exclude=/idea_backup/* --exclude=/pocnetapp/* --exclude=/hppoc/* "

EXCLUDE4="--exclude=/opt/aspera/* --exclude=/opt/ktftp2/*  --exclude=/pm/* --exclude=/super/* --exclude=/previz/*"

EXCLUDE5="--exclude=/env/* --exclude=/fxdata/* --exclude=/fxcache/* --exclude=/katana/* --exclude=/gpfs_backup/* --exclude=/home/$EMPNO/.local/share/Trash/* --exclude=/var/tmp/*"

EXCLUDE6="--exclude=/home/$EMPNO/Desktop/* --exclude=/home/idea/VirtualBox_VMs/*"

if [ $SEED_BACKUP = "N" ]; then
	if [ $QUICK_BACKUP = "Y" ]; then
	##########/home/$EMPNO/Desktop 경로에 너무 많은 용량(10G 이상)이 있을 경우 백업 제외

		DESKTOP_CHECK=`du -sh /home/$EMPNO/Desktop | awk {'print $1'}|uniq`
		DESKTOP_SIZE=`echo ${DESKTOP_CHECK: -1}`
		DESKTOP_REALSIZE=`echo ${DESKTOP_CHECK: 0:-1}`

		if [ $DESKTOP_SIZE = "T" ]; then
		        EXCLUDE_ALL="$EXCLUDE1 $EXCLUDE2 $EXCLUDE3 $EXCLUDE4 $EXCLUDE5 $EXCLUDE6"
		elif [ $DESKTOP_SIZE = "G" ]; then
		        if [ $DESKTOP_REALSIZE > 10 ]; then
				EXCLUDE_ALL="$EXCLUDE1 $EXCLUDE2 $EXCLUDE3 $EXCLUDE4 $EXCLUDE5 $EXCLUDE6"
			else
				EXCLUDE_ALL="$EXCLUDE1 $EXCLUDE2 $EXCLUDE3 $EXCLUDE4 $EXCLUDE5"
			fi
		else
			EXCLUDE_ALL="$EXCLUDE1 $EXCLUDE2 $EXCLUDE3 $EXCLUDE4 $EXCLUDE5"
		fi
	else
		EXCLUDE_ALL="$EXCLUDE1 $EXCLUDE2 $EXCLUDE3 $EXCLUDE4 $EXCLUDE5"
	fi
elif  [ $SEED_BACKUP = "Y" ]; then
	EXCLUDE_ALL="$EXCLUDE1 $EXCLUDE2 $EXCLUDE3 $EXCLUDE4 $EXCLUDE5 $EXCLUDE6"	
fi

tar_system () {

        tar zcpvf $BKDIR/$HEAD/$TEAM/backup_${HOSTNAME}_${DATE}.tar.gz $EXCLUDE_ALL /
        #tar zcpvf /backup.tar.gz $EXCLUDE_ALL /
}

backup_start_message () {
        echo -e "${GREEN}====this system will be backup just in a second.====${RESET}"
	echo -e "${GREEN} BACKUP DIR : $BKDIR/$HEAD/$TEAM/${RESET}"
}

backup_finish_message () {
        echo -e "${GREEN}====backup is done. you can close this window.====${RESET}"
}

start_log (){

	echo -n "${HOSTNAME}_backup start : " >> $BKDIR/$HEAD/$TEAM/history.txt
	date >> $BKDIR/$HEAD/$TEAM/history.txt
	echo "====================" >> $BKDIR/$HEAD/$TEAM/history.txt
}

finish_log (){

        echo -n "${HOSTNAME}_backup finish : " >> $BKDIR/$HEAD/$TEAM/history.txt
        date >> $BKDIR/$HEAD/$TEAM/history.txt
        echo "====================" >> $BKDIR/$HEAD/$TEAM/history.txt
}

sleep_1h(){
	sleep 3600
}


sleep_30m(){
	sleep 1800
}

sleep_manual(){
	echo -n "how much second want to sleep ? : "
	
	read TIME
	sleep $TIME
}

backup_funtion () {
	/idea_backup/script/USERSET/empty_trash.sh
	backup_start_message
	#sleep_manual
	start_log
        tar_system
        finish_log
        backup_finish_message
}



####2D1 team
if [ ${TEAM} = "2DC" ] || [ ${TEAM} = "2D1" ] ; then
        HEAD=2D
        TEAM=2D1
	
	#call backup funtion
	backup_funtion

####2D2 team
elif [ ${TEAM} = "2D2" ] ; then
        HEAD=2D
        TEAM=2D2

	#call backup funtion
        backup_funtion

####2D3 team
elif [ $TEAM = 2D3 ] ; then
        HEAD=2D
        TEAM=2D3

	#call backup funtion
        backup_funtion

####2D4 team
elif [ $TEAM = 2D4 ] ; then
	HEAD=2D
	TEAM=2D4

	#call backup funtion
        backup_funtion

####2D5 team
elif [ $TEAM = 2D5 ] ; then
        HEAD=2D
        TEAM=2D5

	#call backup funtion
        backup_funtion

####2D6 team
elif [ $TEAM = 2D6 ] ; then
        HEAD=2D
        TEAM=2D6

        #call backup funtion
        backup_funtion

####FX team
elif [ $TEAM = FX ] ; then
        HEAD=2D
        TEAM=FX

        #call backup funtion
        backup_funtion

####pipeline team
elif [ $TEAM = pipeline ] ; then
        HEAD=2D
        TEAM=pipeline
	        
	#call backup funtion
        backup_funtion

####3D Animation team
elif [ $TEAM = Animation ] ; then
        HEAD=3D
        TEAM=Animation

        #call backup funtion
        backup_funtion

####3D CFX team
elif [ $TEAM = CFX ] ; then
        HEAD=3D
        TEAM=CFX

        #call backup funtion
        backup_funtion

####3D Environment team
elif [ $TEAM = Environment ] ; then
        HEAD=3D
        TEAM=Environment

        #call backup funtion
        backup_funtion

####3D Lighting team
elif [ $TEAM = Lighting ] ; then
        HEAD=3D
        TEAM=Lighting

        #call backup funtion
        backup_funtion 

####3D MatchMove team
elif [ $TEAM = MatchMove ] ; then
        HEAD=3D
        TEAM=MatchMove

        #call backup funtion
        backup_funtion  

####3D Modeling team
elif [ $TEAM = Modeling ] ; then
        HEAD=3D
        TEAM=Modeling

        #call backup funtion
        backup_funtion

####3D Texture team
elif [ $TEAM = Texture ] ; then
        HEAD=3D
        TEAM=Texture

        #call backup funtion
        backup_funtion

####Management IO team
elif [ $TEAM = Digital_Management ] ; then
        HEAD=Management
        TEAM=Digital_Management

        #call backup funtion
        backup_funtion

####Management planning team
elif [ $TEAM = planning ] ; then
        HEAD=Management
        TEAM=planning

        #call backup funtion
        backup_funtion

####Management Pm_1 team
elif [ $TEAM = pm_1 ] ; then
        HEAD=Management
        TEAM=Pm_1

        #call backup funtion
        backup_funtion

####Management Pm_2 team
elif [ $TEAM = pm_2 ] ; then
        HEAD=Management
        TEAM=Pm_2

        #call backup funtion
        backup_funtion

####Production Previz team
elif [ $TEAM = Previz ] ; then
        HEAD=Production
        TEAM=Previz
        #call backup funtion
        backup_funtion


####Production Supervisor team
elif [ $TEAM = Supervisor ] ; then
        HEAD=Production
        TEAM=Supervisor

        #call backup funtion
        backup_funtion

####Production Supervisor team
elif [ $TEAM = IT ] ; then
        HEAD=IT
        TEAM=""

        #call backup funtion
        backup_funtion


else


	echo ------------------+------------------
	echo -e  "${GREEN}본부를 선택하세요${RESET}"
	echo [1] : 2D
	echo [2] : 3D
	echo [3] : IT
	echo [4] : Management
	echo [5] : Production
	echo [6] : Teambackup
	echo ------------------+------------------
	#끝내기
	echo [q] : 나가기
	echo =====================================

	read HEAD

	case "$HEAD" in
	"1")
	HEAD=2D

		echo ------------------+------------------
		echo -e "${GREEN}팀을 선택하세요${RESET}"
		echo [1] : 2D1
		echo [2] : 2D2
		echo [3] : 2D3
		echo [4] : 2D4
		echo [5] : 2D5
		echo [6] : 2D6
		echo [7] : FX
		echo [8] : pipeline
		echo ------------------+------------------
		#끝내기
		echo [q] : 나가기
		echo =====================================

		read TEAM

		case "$TEAM" in
		"1")
		TEAM=2D1
		;;

		"2")
		TEAM=2D2
		;;

		"3")
		TEAM=2D3
		;;

		"4")
		TEAM=2D4
		;;

		"5")
		TEAM=2D5
		;;

		"6")
		TEAM=2D6
		;;

		"7")
		TEAM=FX
		;;

		"8")
		TEAM=pipeline
		;;

		'q')
		esac;

	;;

	"2")
	HEAD=3D
		echo ------------------+------------------
		echo -e "${GREEN}팀을 선택하세요${RESET}"
		echo [1] : Animation
		echo [2] : CFX
		echo [3] : Environment
		echo [4] : Lighting
		echo [5] : MatchMove
		echo [6] : Modeling
		echo [7] : Texture
		echo ------------------+------------------
		#끝내기
		echo [q] : 나가기
		echo =====================================

		read TEAM

		case "$TEAM" in
		"1")
		TEAM=Animation
		;;

		"2")
		TEAM=CFX
		;;

		"3")
		TEAM=Environment
		;;

		"4")
		TEAM=Lighting
		;;

		"5")
		TEAM=MatchMove
		;;

		"6")
		TEAM=Modeling
		;;

		"7")
		TEAM=Texture
		;;

		'q')
		esac;

	;;

	"3")
	HEAD=IT
	;;

	"4")
	HEAD=Management
		echo ------------------+------------------
		echo -e "${GREEN}팀을 선택하세요${RESET}"
		echo [1] : Digital_Management
		echo [2] : Pm_1
		echo [3] : Pm_2
		echo [4] : planning
		echo ------------------+------------------
		#끝내기
		echo [q] : 나가기
		echo =====================================

		read TEAM

		case "$TEAM" in
		"1")
		TEAM=Digital_Management
		;;

		"2")
		TEAM=Pm_1
		;;

		"3")
		TEAM=Pm_2
		;;

		"4")
		TEAM=planning
		;;

		'q')
		esac;


	;;

	"5")
	HEAD=Production

		echo ------------------+------------------
		echo -e "${GREEN}팀을 선택하세요${RESET}"
		echo [1] : Previz
		echo [2] : Supervisor
		echo ------------------+------------------
		#끝내기
		echo [q] : 나가기
		echo =====================================

		read TEAM

		case "$TEAM" in
		"1")
		TEAM=Previz
		;;

		"2")
		TEAM=Supervisor
		;;

		'q')
		esac;
	;;

        "6")
        HEAD=Teambackup
        ;;

	'q')
	esac;

	echo 
	echo

	COUNT=`ls $BKDIR/$HEAD/$TEAM | wc -l`

	if [ $COUNT = 0 ]; then
		echo -e "${RED}잘못된 경로입니다. 스크립트를 다시 실행해주시기 바랍니다.${RESET}"
	else
		echo -e $BKDIR/${GREEN}$HEAD/$TEAM${RESET}/backup_${HOSTNAME}_${DATE}.tar.gz
		echo -e "${GREEN}위 경로에 백업을 진행하시겠습니까? (Y/N) ${RESET}"
		read choice
			
		case "$choice" in        			
			"Y" | "y" | "yes")        
				backup_funtion
			;;
			*)        
				echo -e "${RED} !!backup was canceled !! ${RESET}"
		esac;

	fi

fi
