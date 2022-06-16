
#!/bin/bash
              
##conf file import
source /idea_backup/script/default/default_conf

DIR=/lustre3/show
echo -e "${GREEN}DIR=${DIR}${RESET}"

##show link 해제
unlink /show

##show link 생성
ln -s ${DIR} /show


