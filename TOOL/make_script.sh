#!/bin/bash

#set -x

source /idea_backup/script/default/default_conf
PWD=`pwd`

insert_funtion(){

echo "
#!/bin/bash
              
##conf file import
source /idea_backup/script/default/default_conf

" >> $SCRIPT.sh
                
chmod 755 $SCRIPT.sh
echo -e "${BOLD}script dir : $PWD/$SCRIPT.sh ${RESET}"

}

echo -ne "${GREEN}스크립트 이름을 입력하세요 : ${RESET}"
read SCRIPT

#insert_funtion

echo -e "${GREEN}Is it right? ${SCRIPT} (Y/N) ${RESET}"
read CHOICE
			
case "$CHOICE" in        
			
		
	"Y" | "y")        
		insert_funtion
	;;
			
	"N" | "n")
		echo -e "!!Check script name !!"
	;;
	     
	*)        
		echo -e "!! Nothing will happen !!"
	esac;


