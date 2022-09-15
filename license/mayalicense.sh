#!/bin/bash

##conf file import
source /idea_backup/script/default/default_conf

GCOUNT=`cat /etc/group | grep adsklic | wc -l`
if [ ${GCOUNT} -eq 0 ]; then
	echo -e "${BOLD} adsklic group 추가${RESET}"
	groupadd adsklic
fi

#### maya service start
echo -e "${BOLD} maya service start ${RESET}"
systemctl start adsklicensing.service

mkdir -p /var/flexlm/

FILE=/var/flexlm/maya.lic
COUNT=`ls ${FILE} | wc -l`
if [ ${COUNT} -eq 0 ]; then
	### if FILE name is null
	echo "SERVER 10.0.99.16 0" > /var/flexlm/maya.lic
	echo "USE_SERVER" >> /var/flexlm/maya.lic
fi

#### maya service check
echo -e "${BOLD} maya service check ${RESET}"
systemctl status adsklicensing.service

