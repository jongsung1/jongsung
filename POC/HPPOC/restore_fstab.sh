#!/bin/bash

####중복 제거를 위해
cat /home/fstab_except_poc.txt | awk '!x[$0]++' > /home/fstab

####fstab 이동
mv /home/fstab /etc/fstab

