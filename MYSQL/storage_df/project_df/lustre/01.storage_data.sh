#!/bin/bash
##############행으로 되어있는 df.txt 파일을 열로 변경하여 storage_data.txt 저장
source /idea_backup/script/default/default_conf

DIR=/idea_backup/script/storage_df/project_df/lustre
for FILE in `cat ${DIR}/df.txt`
do
	echo $FILE >> ${DIR}//storage_data.txt
done
