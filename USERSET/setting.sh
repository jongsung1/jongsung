#!/bin/bash

####################
## 2021-12-03
## choi jongsung
## echo "cd ~" >> /home/$a/.bashrc 추가
## 바탕화면, Desktop 이슈
##
## 2022-01-03
## 프로그램 설치 부분 함수로 만들어 실행 안되게 수정 
####################

if [ `whoami` != "root" ]; then
        echo "root 유저 모드에서 실행하셔야 합니다."
        exit
fi

##########################
PROGRAM_INSTALL=N	##
###프로그램 설치 관련 config (Y/N)
##########################

#사번 검색
a=`expr substr $USER 13 6`
#a=`expr substr $USER 13 7`
#a=program
#hostnamectl set-hostname $a
#ibus-setup

#cp -r /netapp3/dept/ITinfra/yhj/setting/ibus /home/$a/.cache/
echo "ibook"
sh /netapp/INHouse/CentOS/bin/iBookMark_install.sh #ibook설치

echo ".bashrc"
cp /idea_backup/dept/it/yhj/script/.bashrc /home/$a/.bashrc #.bashrc 추가
cp /idea_backup/dept/it/yhj/script/.bashrc /home/idea/.bashrc #.bashrc 추가 to idea // di tool 

#sh /idea_backup/dept/it/yhj/setting/cinnamon_status.sh

echo "firefox_upgrade"
sh /netapp/INHouse/CentOS/bin/firefox_upgrade.sh

echo "rv"
sh /idea_backup/dept/it/yhj/script/rv.sh

echo "program copy"
cp -r /idea_backup/dept/it/yhj/program /opt

echo "print"
sh  /netapp/INHouse/CentOS/bin/printsetting.sh 

#echo mount -a > /etc/rc.local
#systemctl start rc-local

## rc.local --> mount -a change
#mv /backup/script/USERSET/rc.local /etc/rc.d/rc.local

clear 

if [ $PROGRAM_INSTALL = Y ] ; then
	source /idea_backup/script/USERSET/PROGRAM_INSTALL
fi


echo "group add"
sed -e '71s/$/,DIGITALIDEA\\/' -e "71s/$/$a/" /idea_backup/dept/it/yhj/setting/group > /etc/group

echo "user-dirs"
cp /idea_backup/dept/it/yhj/setting/user-dirs.dirs /home/$a/.config/user-dirs.dirs

echo "Desktop"
mv /home/$a/바탕화면 /home/$a/Desktop

echo "sshd"
chmod 600 /etc/ssh/ssh_host_rsa_key
chmod 600 /etc/ssh/ssh_host_ecdsa_key
systemctl restart sshd

echo "rc-local"
sh /netapp/INHouse/CentOS/bin/rc-local.sh

exit 0
