#!/bin/bash
######################################
echo setting-ant
ANT_HOME=/home/hsinjen/CIBPOLICE/apache-ant-1.9.7
PATH=$ANT_HOME/bin:$PATH
export PATH ANT_HOME
export CLASSPATH=.


######################################
echo build dmz.war
ant

######################################

echo clean-tomcat-dmz.war
rm -rf /AP/tomcat/webapps/dmz

echo mv dmz.war
mv ./dmz.war /AP/tomcat/webapps/dmz.war
