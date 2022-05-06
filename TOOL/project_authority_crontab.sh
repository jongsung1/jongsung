
#!/bin/bash
              
##conf file import
source /idea_backup/script/default/default_conf

PWD=`pwd`

for FILE in `cat $PWD/.project.txt`
do
	chown -R idea.DIGITALIDEA\\digitalidea /show/${PROJECT}
done
