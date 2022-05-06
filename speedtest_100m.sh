#!/bin/bash
source /idea_backup/script/default/default_conf

for ((i=1;i<=10;i++))
do
	cd /ifs/dellpocnfs
	echo -e "${GREEN}write${RESET}"
dd if=/dev/zero bs=102400000 count=100 of=/ifs/dellpocnfs/test_file oflag=direct
echo -e "${GREEN}read${RESET}"
dd if=/ifs/dellpocnfs/test_file of=/dev/null bs=102400000
rm -f /ifs/dellpocnfs/test_file
done

