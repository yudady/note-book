#!/bin/bash

systemctl stop tomcat8.service

tomcat="/home/tomcat8/apache-tomcat-8.5.9"

echo "tomcat => $tomcat"

cd $tomcat
tar -zcvf $(date +"tomcat.log.%Y-%m-%d_%H-%M-%S.tar.gz") ./logs/
cd ./logs/
rm -rf *






myPayWorkDir="/home/jenkins/workspace/workspace/order_mypay"
echo "myPayWorkDir => $myPayWorkDir"

echo "go into $myPayWorkDir"
cd $myPayWorkDir


echo "call ant buildDev.xml start"
ant -f buildDev.xml
echo "call ant buildDev.xml success"




tomcatDir="$tomcat/webapps"
echo "tomcatDir => $tomcatDir"



myPayAdminWar="$myPayWorkDir/dist/myPayAdmin/dist/"
myPayOrderWar="$myPayWorkDir/dist/myPayOrder/dist/"


echo "myPayAdminWar => $myPayAdminWar"
echo "myPayOrderWar => $myPayOrderWar"






echo "========================================"
echo "========================================"
echo "========================================"
myPayDir="$tomcatDir/myPay"

if [ -d "$myPayDir" ]
then
	echo "$myPayDir directory  exists!"
	cd $myPayDir
	pwd
	rm -rf "/home/tomcat8/apache-tomcat-8.5.9/webapps/myPay.war"
	
	rm -rf ./*
	ls -la
	cd $myPayAdminWar
	pwd
	ls -la
	cp -r ./* "$tomcatDir/myPay/"
	ls -la
	echo "myPayAdmin ok"
else
	echo "$myPayDir directory not found!"
	exit 1
fi
echo "========================================"
echo "========================================"
echo "========================================"


tomcatOrderDir="$tomcatDir/ROOT"
echo "tomcatOrderDir => $tomcatOrderDir"

if [ -d "$tomcatOrderDir" ]
then
	echo "$tomcatOrderDir directory  exists!"
	cd $tomcatOrderDir
	pwd
	
	rm -rf ./*
	ls -la

	
	cd $myPayOrderWar
	pwd
	ls -la
	cp -r ./* "$tomcatOrderDir/"
	ls -la
	echo "myPayOrder ok"
else
	echo "$tomcatOrderDir directory not found!"
	exit 1
fi



systemctl start tomcat8.service




