#!/bin/bash

mkdir -p /var/flexlm/

FILE=/var/flexlm/maya.lic

if [ -z ${FILE} ]; then
	### if FILE name is null
	echo "SERVER 10.0.99.16 0" >> /var/flexlm/maya.lic
	echo "USE_SERVER" >> /var/flexlm/maya.lic
fi


