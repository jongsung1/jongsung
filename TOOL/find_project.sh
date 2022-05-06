
#!/bin/bash
              
##conf file import
source /idea_backup/script/default/default_conf

echo -ne "${GREEN}insert project name :  ${SCRIPT} ${RESET}"
read PROJECT

find /lustre3/show -maxdepth 2 -name "${PROJECT}"

