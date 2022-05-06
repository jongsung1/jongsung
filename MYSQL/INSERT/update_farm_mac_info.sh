#!/bin/bash
#set -x
source /idea_backup/script/default/default_conf

##########################################################
HOSTNAME=`hostname`
##########################################################
#### MAC_ADDR
MAC_COUNT=`/idea_backup/script/TOOL/MAC_ADD.sh | wc -l`
if [ ${MAC_COUNT} -eq 1 ]; then
	MAC_ADDR1=`/idea_backup/script/TOOL/MAC_ADD.sh`
	MAC_ADDR2=' '
elif [ ${MAC_COUNT} -eq 2 ]; then
	MAC_ADDR1=`/idea_backup/script/TOOL/MAC_ADD.sh | head -1`
	MAC_ADDR2=`/idea_backup/script/TOOL/MAC_ADD.sh | tail -1`
fi
##########################################################
DATE=`date +%s`
##########################################################

mysql_sql(){
	local TABLE=$1
	UPDATE_SQL="
		UPDATE ${TABLE} set
		MAC_ADDR1='${MAC_ADDR1}',
		MAC_ADDR2='${MAC_ADDR2}'
		where HOSTNAME='${HOSTNAME}';
	"
}

update_farm_mac_info(){
        SQL=${UPDATE_SQL}
	#echo -e "${GREEN}$SQL${RESET}"
        mysql -h${MYSQLHOST} -uroot -p${PASSWORD} IDEA -e "${SQL}"
}

FARMCOUNT=`hostname | grep farm | wc -l`
CACHECOUNT=`hostname | grep cache | wc -l`
DPXCOUNT=`hostname | grep dpx | wc -l`
ENVCOUNT=`hostname | grep env | wc -l`
HPFXCOUNT=`hostname | grep hpfx | wc -l`
HPRENDERCOUNT=`hostname | grep hprender | wc -l`

if [ ${FARMCOUNT} -eq 1 ] ; then
	mysql_sql FARM
	update_farm_mac_info
elif [ ${CACHECOUNT} -eq 1 ] ; then
        mysql_sql CACHE
        update_farm_mac_info
elif [ ${DPXCOUNT} -eq 1 ] ; then
        mysql_sql DPX
        update_farm_mac_info
elif [ ${ENVCOUNT} -eq 1 ] ; then
        mysql_sql ENV
        update_farm_mac_info
elif [ ${HPFXCOUNT} -eq 1 ] ; then
        mysql_sql HPFX
        update_farm_mac_info
elif [ ${HPRENDERCOUNT} -eq 1 ] ; then
        mysql_sql HPRENDER
        update_farm_mac_info
else
	echo "maybe user"
fi

echo -e "${GREEN}finish work${RESET}"
