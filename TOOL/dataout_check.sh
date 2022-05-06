#!/bin/bash

#set -x
source /idea_backup/script/default/default_conf

DATAOUT_DIR=/idea_backup/dataout/
SHOW_DATAOUT_DIR=`ls -l ${DATAOUT_DIR}`

echo -e "${BOLD} ${SHOW_DATAOUT_DIR} ${RESET}"
echo -en "${GREEN} insert HEAD :  ${RESET}"
read HEAD

TEAM_COUNT=`ls ${DATAOUT_DIR}/${HEAD} | wc -l`

if [ $TEAM_COUNT = 0 ] ; then
	DIR=${DATAOUT_DIR}/${HEAD}
else
	SHOW_DATAOUT2_DIR=`ls -l ${DATAOUT_DIR}/${HEAD}`
	echo -e "${BOLD} ${SHOW_DATAOUT2_DIR} ${RESET}"
	echo -en "${GREEN} insert TEAM :  ${RESET}"
	read TEAM
	
	DIR=${DATAOUT_DIR}/${HEAD}/${TEAM}
fi

ls -l -R ${DIR} | grep -v mov | grep -v "drw" | grep -v mp4 |  grep -v "합계" 

