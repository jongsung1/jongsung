#!/bin/bash

source /idea_backup/script/default/default_conf


	mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "truncate PROJECT_DF_LUSTRE2"

