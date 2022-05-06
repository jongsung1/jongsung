#!/bin/sh

source /idea_backup/script/default/default_conf

b=`expr substr $USER 13 6`

USER=$(who |grep tty1|awk {'print $1'})

WHOAMI=`whoami`
if [ $WHOAMI != "root" ]; then
        ### if the user is root
        echo -e "${RED} !!!! You are not root permission !!!! ${RESET}"
        exit;
fi

#rv 7.0.0  #라이센스는 위키 license 페이지를 보고 개별 셋팅필요함.
 
echo    10.0.99.91 : 텍스쳐팀
echo    10.0.99.92 : 환경팀
echo    10.0.99.93 : 모델링
echo    10.0.99.94 : 에니메이션
echo    10.0.99.95 : 매치무브
echo    10.0.99.96 : 합성1
echo    10.0.99.97 : 합성2
echo    10.0.99.98 : 합성3
echo    10.0.99.99 : 합성4,5
echo    10.0.99.100 : FX
echo    10.0.99.101 : 리깅
echo    10.0.99.102 : 라이팅팀
echo    10.0.99.103 : 모션, 뉴미디어
echo    10.0.99.104 : PD,PM
echo    10.0.99.105 : FX2
echo    10.0.99.106 : 슈퍼바이져2 
echo    10.0.99.107 : 기타
echo rv LIcense IP :
read a


rv7='rv-Linux-x86-64-7.2.0'
rm -rf /opt/${rv7}
tar xf /lustre3/Applications/Linux/RV/${rv7}.tar -C /opt/
cp -f /netapp/INHouse/Tool/rv/mio_ffmpeg/init.cpp /opt/${rv7}/src/mio_ffmpeg
cd /opt/${rv7}/src/mio_ffmpeg && make && make install
chown -R idea:idea /opt/${rv7}
ln -sf /opt/${rv7}/bin/rv /usr/local/bin/ #localhost에서 rv라고 쳐도 바로 인식되도록.
chmod 775 /opt/${rv7}
su - $USER -c "/opt/${rv7}/bin/rv.install_handler"



#install dilink protocol
su - $USER -c "dilink install"
cp /idea_backup/dept/it/yhj/license/license.gto $rv7/etc/

sed -i "s/abc/$a/g" $rv7/etc/license.gto

cd /idea_backup/dept/it/yhj/infra/

if [ $a == "10.0.99.91" ]; then
	touch loovdev/$b

else if [ $a == "10.0.99.92" ]; then
	touch environment 

else if [ $a == "10.0.99.93" ]; then
	touch modeling/$b

else if [ $a == "10.0.99.94" ]; then
	touch animation/$b

fi

echo "----------------------------------------------"
echo " RV7 설치되었습니다."
echo "----------------------------------------------"
