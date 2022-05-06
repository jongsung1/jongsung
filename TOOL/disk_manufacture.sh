
#!/bin/bash
              
##conf file import
source /idea_backup/script/default/default_conf

#smartctl -iA /dev/sda | grep Device | grep Model

#smartctl -iA /dev/sda | grep Capacity

DISK_TEST1=DISK_T
DISK_TEST2=DISK_T2

fdisk -l | grep Disk | grep dev >> $DISK_TEST1
awk -F ":" '{print $1}' $DISK_TEST1 > $DISK_TEST2
awk -F "Disk " '{print $2}' $DISK_TEST2

for FILE in `cat ./$DISK_TEST2`
do
	smartctl -iA $FILE | grep Device | grep Model
	#smartctl -iA $FILE | grep Capacity
done
rm -f $DISK_TEST1
rm -f $DISK_TEST2
