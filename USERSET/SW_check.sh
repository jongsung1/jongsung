
#!/bin/bash

source /idea_backup/script/default/default_conf

WHOAMI=`whoami`
if [ $WHOAMI != "root" ]; then
        ### if the user is root
        echo -e "${RED} !!!! You are not root permission !!!! ${RESET}"
        exit;
fi

HOSTNAME=`ls /home | grep -v idea | grep -v io`

echo -n "present hostname : "
hostname

echo -e "${GREEN}OS_version${RESET}"
cat /etc/redhat-release

echo -e "${GREEN}CPU_model${RESET}"
cat /proc/cpuinfo | grep "model name" | head -1

echo -e "${GREEN}CPU_core${RESET}"
cat /proc/cpuinfo | grep cores | wc -l

echo -e "${GREEN}Disk${RESET}"

#echo -e "${GREEN}0 : SSD 1 : HDD${RESET}"
#lsblk -d -o name,rota

source /idea_backup/script/TOOL/disk_manufacture.sh

echo -e "${GREEN}Memory${RESET}"
free -h -t

echo -e "${GREEN}Graphics Card${RESET}"
nvidia-smi --query | fgrep 'Product Name'

echo -e "${GREEN}Mainboard-manufacturer${RESET}"
dmidecode -s baseboard-manufacturer

echo -e "${GREEN}Mainboard${RESET}"
dmidecode -s baseboard-product-name

