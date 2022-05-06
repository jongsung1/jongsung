#!/bin/bash

source /idea_backup/script/default/default_conf

HOSTNAME=`hostname`
COL_HOSTNAME='"'${HOSTNAME}'"'
NOWTIME=`date +%s`

INSERT_SQL="
 INSERT INTO USER_STORAGE 
 (USERID, LUSTRE, LUSTRE2, LUSTRE3, NETAPP, CLIB, IDEA_BACKUP, OLD_BACKUP, OLD_BACKUP2, FXDATA, FXCACHE, FX5, ENV, ASPERA, KTFTP2, KATANA, NAS, SUPER, PM, HPPOC, POCNETAPP,DELLPOC,DATE)  
 VALUES
 ("${COL_HOSTNAME}",'N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N',${NOWTIME})
"

SQL=${INSERT_SQL}

insert_storage_info(){
	mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}"
}


insert_storage_info
