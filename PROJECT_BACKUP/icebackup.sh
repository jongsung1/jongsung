#!/bin/sh

DATE=$(date +%Y%m%d)
LOG_DIR=/var/log/icebackuplog/
LOG="${LOG_DIR}/icebackup_$DATE.log"
ERR_LOG="${LOG_DIR}/icebackup_$DATE_err.log"

RSYNC=/usr/bin/rsync
#RSYNC_OPTION="-azvh --progress --bwlimit=40960"
RSYNC_OPTION="-azvh --bwlimit=40960"

####Source
DATA=/lustre2/show/bmyvr
#DATA1=/idea_backup/2018/blueroses
#DATA2=/idea_backup/2018/cherryblue
#DATA3=/idea_backup/2018/rampage

####Destination Server
BACKUP_SERVER=/bmyvr_backup/

mkdir -p $LOG_DIR

#${RSYNC} ${RSYNC_OPTION} ${DATA1} ${DATA2} ${DATA3} ${BACKUP_SERVER} 1>> $LOG 2>> $ERR_LOG
${RSYNC} ${RSYNC_OPTION} ${DATA} ${BACKUP_SERVER} 1>> $LOG 2>> $ERR_LOG

#complte
#/idea_backup/2015/LGHDR
#/idea_backup/2015/cheongshim
#/idea_backup/2015/chilsung
#/idea_backup/2016/facebook
#/idea_backup/2016/ncnewmedia
#/idea_backup/2016/openeyes
#/idea_backup/2016/qyz
#/idea_backup/2016/snow
#/idea_backup/2017/lady
#/idea_backup/2017/newmedia
#/idea_backup/2017/project_review
#/idea_backup/2017/samsaeng
#/idea_backup/2017/whoami
#/idea_backup/2018/dino
#/idea_backup/2018/blueroses
#/idea_backup/2018/cherryblue
#/idea_backup/2018/rampage
