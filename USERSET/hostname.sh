
#!/bin/bash

source /idea_backup/script/default/default_conf

HOSTNAME=`ls /home | grep -v idea | grep -v io`
command="hostnamectl set-hostname "


echo -e -n "${BOLD}$command${RESET}"

echo -e "${BOLD}$HOSTNAME${RESET}"



