#!/bin/bash

#set -x
source /idea_backup/script/default/default_conf

WHOAMI=`whoami`
if [ $WHOAMI != "root" ]; then
        ### if the user is root
        echo -e "${RED} !!!! You are not root permission !!!! ${RESET}"
        exit;
fi

#### version check value
Python2_VERSION_CHECK=`ls -l /usr/bin/python | grep python2 | wc -l`
Python3_VERSION_CHECK=`ls -l /usr/bin/python | grep python3 | wc -l`
Python3_CHECK=`ls -l /usr/bin/python3 | wc -l`

INSTALL_PYTHON3_DIR=/opt/Python-3.7.3

INSTALL_DIR=/netapp/INHouse/CentOS/Python-3.7.3/needs/
PYTHON3_INSTALL_FILE_DIR=/netapp/INHouse/CentOS/

#### version change funtion
change_python_version(){
        VAL1=$1
        rm -f /usr/bin/python
        ln -s /usr/bin/${VAL1} /usr/bin/python
}

before_install_python3(){
        cd $INSTALL_DIR
	rpm -Uvh *.rpm --nodeps
}

install_python3(){
	cp -ar $PYTHON3_INSTALL_FILE_DIR/Python-3.7.3 /opt
        cd $INSTALL_PYTHON3_DIR
        ./configure --enable-optimizations
	make altinstall
}

setting_python3(){
	cd $INSTALL_PYTHON3_DIR
	cp -a python /usr/bin/python3.7
	unlink /usr/bin/python3
	ln -s /usr/bin/python3.7 /usr/bin/python3	
}

### change python version
if [ ${Python2_VERSION_CHECK} -eq 1 ] ;then
	### python2 to python3 if there is python 3
	if [ ${Python3_CHECK} -eq 1 ] ;then
		change_python_version python3
	else
		### if user want to install python 3, then install python3 and change the version.
		echo -en "${RED}there is no python 3. Do you want to install Python 3? (Y/N) : ${RESET}"
		read choice
		case "$choice" in
				"Y" | "y"| "yes")        
					before_install_python3
					install_python3
					setting_python3
					sleep 2
					change_python_version python3
				;;
				"N" | "n"| "no")
					echo -e "${RED}you select No.${RESET}"
                                ;;
				*)        
					echo -e "!! You have wrong answer !! you have to answer yes or no."
				esac;
	fi
elif [ ${Python3_VERSION_CHECK} -eq 1 ] ;then
	### python3 to python2
	change_python_version python2
else
	change_python_version python2
fi

### check python version
echo -en "${GREEN} your python version is : "
python -V
echo -e "${RESET}"
