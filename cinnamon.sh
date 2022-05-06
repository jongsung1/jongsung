
#!/bin/bash

cd /opt
wget -c http://10.0.0.148:/opt/cinnamon.tar
tar -xvf cinnamon.tar
cd /opt/cinnamon
yum -y install *

