#!/bin/bash
#set -x
##conf file import
source /idea_backup/script/default/default_conf

WHOAMI=`whoami`
if [ $WHOAMI != "root" ]; then
        ### if the user is root
        echo -e "${RED} !!!! You are not root permission !!!! ${RESET}"
        exit;
fi

##################
AUTO_MOUNT=Y	#### 마운트 체크시 자동 마운트(Y/N)
#AUTO_MOUNT=N	#### 마운트 체크시 자동 마운트(Y/N)
##################

HISTORY=history.txt
HOSTNAME=`hostname`

DF=df__.txt
FSTAB=fstab__.txt
TEMP=temp__.txt
TEMP1=temp1__.txt

FIRST=first___.txt
SECOND=second___.txt

## fstab UUID, "#" delete
cat /etc/fstab | grep  "\n" | grep -v "#" | grep -v UUID | grep -v swap > ${FIRST}
awk -F "nfs" '{print $1}' ${FIRST} > ${SECOND}
awk -F " " '{print $2}' ${SECOND} > $FSTAB

add_compare(){
        local value=$1
        count=`cat /etc/fstab | grep ${value} | wc -l`
        if [ $count != 0 ] ; then
                echo "${value}" >> $FSTAB
        fi
}

add_compare /hppoc

rm -f ${FIRST}
rm -f ${SECOND}

## df -h status
df -h | grep -v run | grep -v dev | grep -v boot | grep -v sys > $DF

## filename change -> hostname+fstab and delete dup line
cat $FSTAB | awk '!x[$0]++' > ${HOSTNAME}_${FSTAB}

## filename change -> hostname+df
mv $DF ${HOSTNAME}_${DF}

## setting to compare $C_FSTAB to $C_DF
C_FSTAB=${HOSTNAME}_${FSTAB}
C_DF=${HOSTNAME}_${DF}

## compare C_FSTAB to C_DF
for FILE in `cat ./$C_FSTAB`
do
	COUNT=`cat $C_DF | grep $FILE |wc -l`
	if [ $COUNT = 0 ] ; then
		echo -e "${RED}${FILE} is not mounted${RESET}"
		echo "===================="
		if [ $AUTO_MOUNT = Y ] ; then
			mount ${FILE}
		fi
else
	if [ ${FILE} = "/lustre" ] ; then
		lustre_count=`cat $C_DF | grep $FILE |grep -v lustre2 | grep -v lustre3 | wc -l`
		if [ $lustre_count = 0 ] ; then
			echo -e "${RED}${FILE} is not mounted${RESET}"
			echo "===================="
			if [ $AUTO_MOUNT = Y ] ; then
                  	      mount ${FILE}
	                fi
		else
			echo -e "${GREEN} ${FILE} is mounted ${RESET}"
			echo "===================="
		fi
	else
		echo -e "${GREEN} ${FILE} is mounted ${RESET}"
		echo "===================="
	fi
fi
done

## after check, file delete
rm -f $C_DF
rm -f $DF
rm -f $C_FSTAB
rm -f $FSTAB
