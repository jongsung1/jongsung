

#!/bin/bash

source /idea_backup/script/default/default_conf

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

mysql_seq_sql(){
        local column=$1
        local table=$2
        SELECT_SQL="select FARMIP from ${table} where seq='${column}';"
        SQL=${SELECT_SQL}
}

get_farmip_by_seq(){
        local column=$1
        local table=$2
        mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}" > ${DIR}/${table}_farmip_tmp.txt
	cat ${DIR}/${table}_farmip_tmp.txt |  grep -v FARMIP > farmip.txt
	rm -f ${DIR}/${table}_farmip_tmp.txt
}

