
#!/bin/bash
              

ip addr | grep BROADCAST| grep UP| grep -v DOWN | awk -F: '{print $2}' | tr -d ' ' > NIC.txt

for FILE in `cat NIC.txt`
do
	ip link show ${FILE} | grep ether| awk '{print $2}' ## MAC address
done

rm -f NIC.txt
