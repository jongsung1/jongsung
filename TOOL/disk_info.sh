
#!/bin/bash
              
##conf file import
source /idea_backup/script/default/default_conf

#smartctl -iA /dev/sda | grep Device | grep Model

#smartctl -iA /dev/sda | grep Capacity

df -h | grep boot > qq.txt
awk -F "dev/" '{print $2}' qq.txt > qq1.txt

BOOT=`awk -F " " '{print $1}' qq1.txt`

COUNT=`smartctl -iA /dev/${BOOT} | grep Device | grep Model | wc -l`

if [ ${COUNT} = 2 ]; then
	smartctl -iA /dev/${BOOT} | grep Device | grep Model
else
	smartctl -iA /dev/${BOOT} | grep Model
fi

rm -f qq*
