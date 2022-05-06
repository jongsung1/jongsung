
#!/bin/bash
              
source /idea_backup/script/default/default_conf

NIC=`ip addr | grep BROADCAST| grep UP| grep -v DOWN | awk -F: '{print $2}' | tr -d ' '`
IP=`ip addr | grep 'inet ' | grep brd | awk '{print $2}' | awk -F/ '{print $1}' | sed -e '4, $d' | grep -v 192.168.122.1`


echo -ne "${GREEN}active NIC : ${RESET}"
echo -e "${GREEN}${NIC}${RESET}"

echo -ne "${GREEN}active IP : ${RESET}"
echo -e "${GREEN}${IP}${RESET}"

echo -ne "${GREEN}INSERT NEW IP  ${RESET}"
read NEWIP

sed -i "s/${IP}/${NEWIP}/g" /etc/sysconfig/network-scripts/ifcfg-${NIC}

cat /etc/sysconfig/network-scripts/ifcfg-${NIC}

