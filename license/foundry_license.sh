#/bin/bash

count=`ls /usr/local/foundry/RLM | grep -v log | grep lic | wc -l`
#count : 1 - license file is exist
#count : 0 - license file is not exist

LIC=`cat /usr/local/foundry/RLM/foundry_client.lic | grep HOST | grep 10.0.99. | grep 4101 | wc -l`
#LIC : 1 - license file is exist
#LIC : 0 - license file is not exist

license_host=10.0.99.91

#make license dir
mkdir -p /usr/local/foundry/RLM

if [ $count = 1 ] ; then 

	#file check
	if [ $LIC = 1 ] ; then
		echo "license OK"		
	else
		#backup and insert license file
		cp -a /usr/local/foundry/RLM/foundry_client.lic /usr/local/foundry/RLM/foundry_client.lic_bk
        	echo "HOST $license_host any 4101" > /usr/local/foundry/RLM/foundry_client.lic
	fi
else
	echo "HOST $license_host any 4101" > /usr/local/foundry/RLM/foundry_client.lic
fi

