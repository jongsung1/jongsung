
#!/bin/bash
              
source /idea_backup/script/default/default_conf

DIR=/lustre2/show/bmyvr
#/netapp/INHouse/MAYA_DEV_temp

find $DIR -type l -printf "%p --> %l\n"
