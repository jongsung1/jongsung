#!/bin/bash

source /idea_backup/script/default/default_conf

DIR=/idea_backup/script/MYSQL/storage_df/

for FILE in `cat ${DIR}/df.txt`
do
	echo $FILE >> ${DIR}/storage_data.txt
done
