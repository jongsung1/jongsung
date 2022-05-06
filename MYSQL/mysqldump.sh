#!/bin/bash

##conf file import
source /idea_backup/script/default/default_conf
DATE=`date +"%y%m%d"`
DUMPDIR=/idea_backup/script/MYSQL/dump/IDEA_${DATE}.sql

set -x
mysql_dump(){
	mysqldump -u root -p${PASSWORD} IDEA > ${DUMPDIR}
}

#mysql_dump
mysqldump --single-transaction -u root -p${PASSWORD} IDEA > ${DUMPDIR}
