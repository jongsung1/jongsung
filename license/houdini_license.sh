
#!/bin/bash
              
##conf file import
source /idea_backup/script/default/default_conf

##### 후디니 설치 경로
H_DIR17=/opt/hfs17.5.173
H_DIR18=/opt/hfs18.5
H_DIR19=/opt/hfs19.0

##### hserver process kill 함수
hserver_process_kill () {
	PID=`ps -ef | pgrep hserver | grep -v grep`
	############## hserver process kill
	kill -9 $PID
}

##### hserver process start 함수
hserver_process_start () {
	############## hserver process start
	source houdini_setup
	hserver
	############## hserver process check
	hserver -l
}

##### 19부터 있는 경로에서 함수 실행 - 경로가 있으면 실행 없으면 다음 조건
if [ -d "$H_DIR19" ];then
	hserver_process_kill
	cd $H_DIR19
	hserver_process_start	
elif [ -d "$H_DIR18" ]; then
	hserver_process_kill
	cd $H_DIR18
	hserver_process_start
elif [ -d "$H_DIR17" ]; then
	hserver_process_kill
	cd $H_DIR17
	hserver_process_start
else
	echo "후디니 경로가 없습니다."
fi
 

