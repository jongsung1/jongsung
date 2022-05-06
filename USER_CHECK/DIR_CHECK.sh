#!/bin/bash


MOUNT_CHECK_DIR=/idea_backup/script/USERSET/


if [ ! -d "${MOUNT_CHECK_DIR}" ];then
	echo "NO"
elif [ -d "${MOUNT_CHECK_DIR}" ];then
	echo "YES"
fi

