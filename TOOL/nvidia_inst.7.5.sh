#!/bin/bash

set -x
#mkdir /opt/nvidia -p
#cd /opt/nvidia
#wget -c http://10.0.0.148/opt/NVIDIA-Linux-x86_64-440.100.run

#chmod 777 NVIDIA-Linux-x86_64-440.100.run

#a/opt/nvidia/NVIDIA-Linux-x86_64-440.100.run 

## check driver version
nvidia-smi

pwd=`pwd`
NVIDIA=NVIDIA-Linux-x86_64-470.82.00.run

$pwd/$NVIDIA --kernel-source-path=/usr/src/kernels/`uname -r`/ --accept-license -q -s --no-x-check --disable-nouveau --run-nvidia-xconfig --log-file-name=/root/nvidia-installer.log

## check driver version
nvidia-smi
