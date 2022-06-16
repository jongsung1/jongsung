#!/bin/bash
              
##conf file import
source /idea_backup/script/default/default_conf

SOURCEDIR=/lustre3/show/
TARGETDIR=/ANbackup/linktest/
LIST=link_list.txt

for FILE in `cat $LIST`
do
	ln -s ${SOURCEDIR}/${FILE} ${TARGETDIR}/${FILE}
done
