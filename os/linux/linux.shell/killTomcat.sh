#!/bin/bash

# kill tomcat and backup log

#ps -ef | grep '/home/tomcat8/apache-tomcat-8.5.9/conf/logging.properties' | grep -v grep | awk '{print $2}' | xargs -r kill -9 >/dev/null 2>&1
ps -ef | grep java | grep -v jenkins | grep -v grep | awk '{print $2}' | xargs -r kill -9 >/dev/null 2>&1

#cd /home/tomcat8/apache-tomcat-8.5.9/
#tar -zcvf $(date +"tomcat.log.%Y-%m-%d_%H-%M-%S.tar.gz") ./logs/
#cd ./logs/
#rm -rf *



