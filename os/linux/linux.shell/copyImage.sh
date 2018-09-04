#!/bin/bash
# 拷貝圖片


#/bin/cp -rf /home/tomcat8/upload /home/tomcat8/uploadBack
rsync -avP /home/tomcat8/upload/ /home/tomcat8/uploadBack/ &>/dev/null
