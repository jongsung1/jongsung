#!/bin/bash

source /idea_backup/script/default/default_conf
WHOAMI=`whoami`
if [ $WHOAMI != "root" ]; then
        ### if the user is root
        echo -e "${RED} !!!! You are not root permission !!!! ${RESET}"
        exit;
fi


#a=`expr substr $USER 13 6`
cd /home

a=$(ls -l | awk '{print $3}' | grep 1 | sed -n '1,1p' | cut -b13,14,15,16,17,18)
echo $a


sleep 30
b=$(/opt/pbis/bin/find-user-by-name $a@digitalidea.co.kr | grep Gecos | awk '{print $2$3$4}')

echo $b

echo "영어이름(성 제외)"
read b

echo "한글이름(성 포함)"
read c

cd /netapp/INHouse/houdini/users
mkdir $b
chmod -R 777 $b
#echo alias n10='"'"rm -rf ~/.nuke && n10"'"' >> /home/$a/.bashrc
echo export fxuser='"'"$b"'"' >> /home/$a/.bashrc
echo export FXUSER='"'"$b"'"' >> /home/$a/.bashrc
echo export FXNAME='"'"$c"'"' >> /home/$a/.bashrc

#sh /netapp/INHouse//CentOS/bin/fxcache.sh 
