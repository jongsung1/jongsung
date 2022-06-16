
#!/bin/bash
              
##conf file import
source /idea_backup/script/default/default_conf

#set -x
LIST=link_list.txt

for FILE in `cat $LIST`
do
	unlink ${FILE}
done


