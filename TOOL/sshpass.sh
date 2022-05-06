
#!/bin/bash
              
source /idea_backup/script/default/default_conf

##target server infomation
#ID="root"
#PASSWORD="rhdid8cmd!"

for FILE in `cat ./ssh_list.txt`
do
	sshpass -p${PASSWORD} ssh -o StrictHostKeyChecking=no ${ID}@${FILE} hostname -I ;echo hi;sleep 10;df -h;sleep 10
done
