#!/bin/bash

TABLE=USER_INFO
PING_COUNT=3
TIME=20
DIR=`pwd`

NOWTIME=`date +%s`

update(){
        SQL=${UPDATE_SQL}
        mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}"
}

get_ip_by_seq(){
        local column=$1
        local table=$2
        mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}" > ${DIR}/${table}_userip_tmp.txt
	cat ${DIR}/${table}_userip_tmp.txt |  grep -v USERIP > userip.txt
	rm -f ${DIR}/${table}_userip_tmp.txt
}

mysql_seq_sql(){
        local column=$1
        local table=$2
        SELECT_SQL="select USERIP from ${table} where seq='${column}' and OS='L';"
        SQL=${SELECT_SQL}
}


mysql_sql(){
        local column=$1
        local table=$2
        SELECT_SQL="select max(${column}) from ${table} ;"
        SQL=${SELECT_SQL}
}

get_max_seq(){
        local column=$1
        local table=$2
        mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}" > ${DIR}/${table}_seq_tmp.txt
        cat ${DIR}/${table}_seq_tmp.txt | grep -v ${column} > max_seq.txt
        rm -f ${DIR}/${table}_seq_tmp.txt
}

