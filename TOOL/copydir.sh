#!/bin/bash
 
##conf file import
source /idea_backup/script/default/default_conf

#set -x

echo "현재 경로(.)를 타겟으로 복사함 -p "target" "
echo "CMD : find . -type d -exec mkdir -p "/idea_backup/image_backup_temp/{}" \;"
echo "CMD : find . -type d -exec mkdir -p "/pocnetapp/image_backup_temp/{}" \; "
echo "CMD : find . -type d -exec mkdir -p "/netapp/image_backup_temp/{}" \; "


