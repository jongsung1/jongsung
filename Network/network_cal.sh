
#!/bin/bash
 
#set -x             
##conf file import
source /idea_backup/script/default/default_conf

#LIST=/idea_backup/script/SSHuser/user_IP_list.txt
WHO=`whoami`

## when the source server does not have iperf rpm

COUNT=`rpm  -qa | grep iperf | wc -l`
if [ $COUNT = 0 ]; then
	if [ $WHO = root ]; then
		yum install -y iperf
	else
        	sbr /idea_backup/script/Network/yum_iperf.sh
	fi
fi


echo -ne "${GREEN} waht server do you want to join? : ${RESET}"
read INPUT

iperf -c $INPUT
