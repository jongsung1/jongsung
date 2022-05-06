
#!/bin/bash
              
##conf file import
source /idea_backup/script/default/default_conf


echo -ne "${GREEN}프로젝트 이름을 입력하세요 : ${RESET}"
read PROJECT

echo -e "${GREEN}Is it right? ${PROJECT} (Y/N) ${RESET}"
read CHOICE
			
case "$CHOICE" in        
	"Y" | "y")        
		chown -R idea.DIGITALIDEA\\digitalidea /show/${PROJECT}
	;;
	"N" | "n")
		echo -e "!!Check script name !!"
	;;
	*)        
		echo -e "!! Nothing will happen !!"
	esac;
