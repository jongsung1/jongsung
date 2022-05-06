

#!/bin/bash

source /idea_backup/script/default/default_conf
sshpass -p${PASSWORD} ssh -o StrictHostKeyChecking=no root@${HOST} /idea_backup/script/HEALTHCHECK/RENDERFARM_check/ALL_healthcheck.sh
