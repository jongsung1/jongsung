
#!/bin/bash
              
##conf file import
source /idea_backup/script/default/default_conf

PID=`ps -ef | pgrep shutdown`

############## delete process kill
kill -9 $PID



#for FILE in `cat NIC.txt`
#do
#	IP=`ip addr | grep $FILE | grep global| awk -F "/" '{print $1}' | awk -F "inet" '{print $2}'`
#	echo -en "${GREEN}${FILE} :${RESET}"
#	echo -e "${GREEN}${IP}${RESET}"
#done
