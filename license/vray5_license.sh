
#!/bin/bash

LICDIR=/home/idea/.ChaosGroup
SCDIR=/idea_backup/script/license

insert_licence(){
	if [ -d "$LICDIR" ]; then
                sed -i "s/10.0.99.16/10.0.98.1/g" /home/idea/.ChaosGroup/vrlclient.xml
                cat /home/idea/.ChaosGroup/vrlclient.xml
        else
                echo "경로가 없습니다."
                echo -n "경로가 없습니다." >> /backup/script/license/vrayfarm.txt
                hostname -I >> /backup/script/license/vrayfarm.txt
        fi
}

if [ -d "$SCDIR" ]; then
	insert_licence
else
	mount /idea_backup
	insert_licence

fi

