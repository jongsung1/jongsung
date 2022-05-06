#!/bin/bash
PWD=`pwd`
FILE=${PWD}/a.txt

COUNT=10

while [ ${COUNT} -ne 0 ] ; do
        COUNT=`sed '$d' ${FILE} | tail -n 1 | grep poc | wc -l`
	sed -i '$d' ${FILE} | tail -n 30
done
