
#!/bin/bash
              
source /idea_backup/script/default/default_conf

ip addr | grep BROADCAST| grep UP| grep -v DOWN | awk -F: '{print $2}' | tr -d ' ' > NIC.txt

for FILE in `cat NIC.txt`
do
	IP=`ip addr | grep $FILE | grep global| awk -F "/" '{print $1}' | awk -F "inet" '{print $2}'`
	echo -en "${GREEN} ${FILE} :${RESET}"
	echo -e "${GREEN}${IP}${RESET}"

	echo -en "        "
	cat /etc/sysconfig/network-scripts/ifcfg-${FILE} | grep -v "#"| grep BOOTPROTO	### static or dhcp
	ethtool ${FILE} | grep Speed	### NIC speed
	ethtool ${FILE} | grep detected	### NIC status
	echo -en "        "
	ip link show ${FILE} | grep ether| awk '{print $2}' ## MAC address
done

rm -f NIC.txt
