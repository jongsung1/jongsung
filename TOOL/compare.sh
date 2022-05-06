
#!/bin/bash

GREEN="\\033[1;32m"
BOLD="\\033[1m"
RESET="\\033[0m"
PWD=`pwd`

#### ORG에 있고 COPY에 없는 내용은 result에 저장
ORG=org.txt
COPY=copy.txt
RESULT=result.txt


#set -x

for FILE in `cat /$PWD/$ORG`
do
	count=`cat $COPY | grep $FILE | wc -l`
	if [ $count = 0 ] ; then
		echo $FILE >> $RESULT
	else
		echo 
		#$FILE >> $RESULT
	fi
done
