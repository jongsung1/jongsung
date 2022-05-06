
#!/bin/bash
              
source /idea_backup/script/default/default_conf

echo -e "${BOLD} cat FILE1 | awk '!x[$0]++' > FILE2 ${RESET}"
