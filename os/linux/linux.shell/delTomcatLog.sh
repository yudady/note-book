#!/bin/bash
# del tomcat log

cd /home/tomcat8/apache-tomcat-8.5.9/


targetDay=$(date +%Y-%m-%d  --date "4 days ago")
#echo $targetDay


delFile=$( ls | grep $targetDay )
#echo $delFile
rm -rf $delFile
