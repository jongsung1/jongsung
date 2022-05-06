
#!/bin/bash
 
#set -x             
##conf file import
source /idea_backup/script/default/default_conf
source /idea_backup/script/MYSQL/get_user_info.sh

#LIST=/idea_backup/script/SSHuser/user_IP_list.txt
WHO=`whoami`

## when the source server does not have sshpass rpm

COUNT=`rpm  -qa | grep sshpass | wc -l`
if [ $COUNT = 0 ]; then
	if [ $WHO = root ]; then
		yum install -y sshpass-1.06-2.el7.x86_64
	else
        	sbr /idea_backup/script/SSHuser/yum_sshpass.sh
	fi
fi


echo -ne "${GREEN} what user do you want to join? : ${RESET}"
read INPUT

### get EMPNO // But Motion , Matte
HOSTNAME=`iu $INPUT | grep -v Motion | grep -v Matte | awk {'print $1'} `

### get EMP IP 
#IPADDR=`cat $LIST | grep $EMPNO | awk {'print $3'}`
mysql_sql USERIP
IPADDR=`get_user_info USERIP`

echo $IPADDR


sshpass -p${PASSWORD} ssh -o StrictHostKeyChecking=no ${ID}@${IPADDR}

